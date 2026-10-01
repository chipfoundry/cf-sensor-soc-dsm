/*
 * SPDX-FileCopyrightText: 2026 ChipFoundry
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <defs.h>
#include <stub.c>

/*
 * Sensor AFE eval firmware — Wishbone CSR at 0x30000000.
 *
 * Word offsets: 0 ID, 1 CTRL, 2 STATUS (dout[7:0]), 3 HIZ.
 * CTRL[0] is DSM reset_b. disable_mod and sleep stay low.
 * HIZ[1] is enable_hv. pd and the path disables stay low.
 *
 * Analog GPIOs 7-29 and 31-34 match user_defines.v. GPIO 30 is unused.
 * UART TX is GPIO 6.
 * Caravel LA probes are unused.
 */

#define AFE_BASE           ((volatile uint32_t *)0x30000000)
#define AFE_ID             0
#define AFE_CTRL           1
#define AFE_STATUS         2
#define AFE_HIZ            3
#define AFE_CTRL_RESET_B   (1u << 0)
#define AFE_HIZ_ENABLE_HV  (1u << 1)
#define AFE_ID_VALUE       0xAFE00020u

static void delay(int n)
{
	int i;
	for (i = 0; i < n; i++)
		asm volatile("nop");
}

static void print_hex12(unsigned int v)
{
	static const char hex[] = "0123456789ABCDEF";
	putchar(hex[(v >> 8) & 0xF]);
	putchar(hex[(v >> 4) & 0xF]);
	putchar(hex[v & 0xF]);
}

static int afe_enable(void)
{
	reg_wb_enable = 1;
	if (AFE_BASE[AFE_ID] != AFE_ID_VALUE)
		return -1;
	AFE_BASE[AFE_HIZ] = AFE_HIZ_ENABLE_HV;
	AFE_BASE[AFE_CTRL] = AFE_CTRL_RESET_B;
	delay(40);
	return 0;
}

static unsigned int afe_sample(void)
{
	delay(40);
	return AFE_BASE[AFE_STATUS] & 0xFFu;
}

void main()
{
	unsigned int code;

	reg_mprj_io_6 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_7 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_8 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_9 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_10 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_11 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_12 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_13 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_14 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_15 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_16 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_17 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_18 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_19 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_20 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_21 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_22 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_23 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_24 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_25 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_26 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_27 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_28 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_29 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_30 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_31 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_32 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_33 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_34 = GPIO_MODE_USER_STD_ANALOG;
	reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;

	reg_uart_enable = 1;
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1)
		;

	if (afe_enable()) {
		print("ID fail\n");
		for (;;)
			;
	}

	code = afe_sample();
	/* GPIO 37 flags the classic testbench after a successful Wishbone sample. */
	reg_mprj_datah = 0x20;

	print("AFE ready\n");
	print("ID AFE00020\n");
	print("ADC ");
	print_hex12(code);
	print("\n");
	for (;;) {
		print("ADC ");
		print_hex12(afe_sample());
		print("\n");
	}
}
