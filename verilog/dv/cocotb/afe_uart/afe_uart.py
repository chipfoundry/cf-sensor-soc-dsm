# SPDX-FileCopyrightText: 2026 ChipFoundry
# SPDX-License-Identifier: Apache-2.0

from caravel_cocotb.caravel_interfaces import test_configure
from caravel_cocotb.caravel_interfaces import report_test
import cocotb
from caravel_cocotb.caravel_interfaces import UART
from cocotb.triggers import Timer

# Firmware sets HIZ enable_hv. vinp1 forced high makes out1 high, and the
# DSM ideal model copies that pin onto dout[0], so the printed byte is 0x001.
ADC_CODE = "ADC 001"
AFE_ID_LINE = "ID AFE00020"


async def _poke_afe_inputs(dut):
    from cocotb.handle import Force

    hiz = dut.uut.chip_core.mprj.u_cf_buf_hiz.u_core
    hiz.vinp1.value = Force(1)
    hiz.vinp2.value = Force(0)
    await Timer(1, units="ns")


@cocotb.test()
@report_test
async def afe_uart(dut):
    caravelEnv = await test_configure(dut, timeout_cycles=4000000)
    uart = UART(caravelEnv)
    await caravelEnv.wait_mgmt_gpio(1)
    try:
        await _poke_afe_inputs(dut)
    except Exception as exc:
        cocotb.log.error(f"[TEST] could not force HIZ inputs: {exc}")
        return
    ready = await uart.get_line()
    if "AFE ready" not in ready:
        cocotb.log.error(f"[TEST] expected AFE ready, got '{ready}'")
        return
    ident = await uart.get_line()
    if ident.strip() != AFE_ID_LINE:
        cocotb.log.error(f"[TEST] expected '{AFE_ID_LINE}', got '{ident}'")
        return
    adc = await uart.get_line()
    if adc.strip() != ADC_CODE:
        cocotb.log.error(f"[TEST] expected '{ADC_CODE}', got '{adc}'")
        return
    cocotb.log.info(f"[TEST] Pass UART '{ready}' / '{ident}' / '{adc}'")
