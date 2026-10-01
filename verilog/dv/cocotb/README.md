# SPDX-FileCopyrightText: 2026 ChipFoundry
# SPDX-License-Identifier: Apache-2.0

# Cocotb tests

`afe_uart` is the sensor AFE UART bring-up test. `cocotb_tests.py` imports it.
`all_tests.yaml` is what `cf verify --all` runs.

## afe_uart

Firmware (`afe_uart/afe_uart.c`) enables the user Wishbone IF, checks CSR
`ID == 0xAFE00020`, writes `CTRL` (`reset_b`), reads `dout`, and prints:

```
AFE ready
ID AFE00020
ADC 001
```

The Python bench forces HIZ `vinp1` high after management GPIO goes high.
Firmware sets `enable_hv`. The DSM ideal model copies HIZ `out1` onto `dout[0]`.

```bash
cf verify afe_uart
```

Or, from this directory with `caravel_cocotb` on `PATH`:

```bash
caravel_cocotb -t afe_uart -tag afe_uart
```
