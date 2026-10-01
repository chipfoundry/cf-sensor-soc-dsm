<!---
# SPDX-FileCopyrightText: 2026 ChipFoundry
# SPDX-License-Identifier: Apache-2.0
-->

# Sensor AFE verification

The only DV pattern in this tree is **`afe_uart`**.

Firmware talks to `afe_wb` over Wishbone (`0x30000000`): check `ID`, write
`CTRL` (`reset_b`), read `STATUS` `dout[7:0]`, and print that byte on UART
TX (GPIO 6). Analog GPIOs 7–29 and 31–34 match `user_defines.v`.
Caravel Logic Analyzer pins are unused.

## Run (ChipFoundry CLI)

```bash
cf verify afe_uart
# or
cf verify --all
```

`--all` uses `verilog/dv/cocotb/all_tests.yaml`. RTL sim compiles
`ip/CF_BUF_HIZ/verify/beh_model/CF_BUF_HIZ_core.v`,
`ip/CF_ADC_DSM20/verify/beh_model/CF_ADC_DSM20_core.v`,
`ip/CF_BGR/verify/beh_model/CF_BGR_core.v`, and
`ip/CF_REFBUF/verify/beh_model/CF_REFBUF_core.v` in place of the empty
`hdl/gl/*_core.v` stubs.

Expected UART:

```
AFE ready
ID AFE00020
ADC 001
```

(`ADC 001` is the DSM ideal model: HIZ `vinp1` is forced high, `enable_hv`
is set, and `dout[0]` follows `out1`.)

Classic Verilog TB (`verilog/dv/afe_uart/`): pass is GPIO 37 after a successful
Wishbone sample. SDF, when enabled, annotates `user_project_wrapper`, not a
removed `user_proj_example` netlist.

## Docker / Makefile (legacy)

```bash
make simenv
SIM=RTL make verify-afe_uart
```

See [local-install.md](./local-install.md) for a non-Docker setup.
