/*
 * SPDX-FileCopyrightText: 2026 ChipFoundry
 * SPDX-License-Identifier: Apache-2.0
 *
 * Sensor SoC eval: AFE sample burst into SRAM, print on mgmt UART (GPIO 6).
 */

#include <defs.h>
#include <stub.c>

#define AFE_BASE           ((volatile uint32_t *)0x30000000)
#define CAP_BASE           ((volatile uint32_t *)0x30007000)
#define SRAM_BASE          ((volatile uint32_t *)0x30010000)

#define AFE_ID             0
#define AFE_CTRL           1
#define AFE_CTRL_RESET_B   (1u << 0)
#define AFE_ID_VALUE       0xAFE00020u

#define CAP_ID             0
#define CAP_CTRL           1
#define CAP_COUNT          2
#define CAP_STATUS         3
#define CAP_ID_VALUE       0x50C00001u
#define CAP_STATUS_BUSY    (1u << 16)
#define CAP_STATUS_DONE    (1u << 17)

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

void main()
{
	unsigned int i, st, n = 8;

	reg_mprj_io_6 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_uart_enable = 1;
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1)
		;

	reg_wb_enable = 1;
	if (AFE_BASE[AFE_ID] != AFE_ID_VALUE || CAP_BASE[CAP_ID] != CAP_ID_VALUE) {
		print("ID fail\n");
		for (;;)
			;
	}

	AFE_BASE[AFE_CTRL] = AFE_CTRL_RESET_B;
	delay(40);
	CAP_BASE[CAP_COUNT] = n;
	CAP_BASE[CAP_CTRL] = 1;

	for (i = 0; i < 8000; i++) {
		st = CAP_BASE[CAP_STATUS];
		if (st & CAP_STATUS_DONE)
			break;
		delay(40);
	}

	print("SOC ready\n");
	for (i = 0; i < n; i++) {
		print("SRAM ");
		print_hex12(SRAM_BASE[i] & 0xFFu);
		print("\n");
	}
	for (;;)
		;
}
