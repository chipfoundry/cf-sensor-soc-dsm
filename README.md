<div align="center">

<img src="https://umsousercontent.com/lib_lnlnuhLgkYnZdkSC/hj0vk05j0kemus1i.png" alt="ChipFoundry Logo" height="140" />

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![ChipFoundry Marketplace](https://img.shields.io/badge/ChipFoundry-Marketplace-6E40C9.svg)](https://platform.chipfoundry.io/marketplace)

</div>

# cf-sensor-soc-dsm

ChipFoundry **DSM sensor SoC** reference application on Caravel. This is a
fork of [`cf-sensor-soc`](https://github.com/chipfoundry/cf-sensor-soc): the
same digital ring (UART, SPI, I2C, three 32-bit timers, and 4 KB SRAM) and
the same HIZ / bandgap / reference-buffer front end, with `CF_ADC_SAR12`
and `sar_refs` replaced by `CF_ADC_DSM20`.

`cf-sensor-soc` is unchanged. Hardened `soc_sys` and `user_project_wrapper`
views from that tree are not in this fork. SRAM wrapper views are.

## What changed

`afe_wb` still sits at `0x30000000`. Its ID is `0xAFE00020`. CTRL bit 0 is
the DSM `reset_b`. `disable_mod` and `sleep` stay low to run. STATUS[7:0]
is `dout`. The ideal model copies the HIZ `out1` pin onto `dout[0]` each
Wishbone clock. It does not perform a 12-to-20-bit conversion.

The modulator clock is `wb_clk_i`. Caravel `user_clock2` stays in the
wrapper port list and is unused.

Write `1` to CAP_CTRL and `N` to CAP_COUNT. Each SRAM round-trip stores
`{22'b0, overload_det_one, overload_det_zero, dout[7:0]}` until `N` words.
Caravel mgmt UART on GPIO 6 still prints codes. Enable each CF_* `GCLK`
register (`+0xFF10`) before using that peripheral.

| Block | Address | Role |
| --- | --- | --- |
| `afe_wb` | `0x30000000` | DSM / HIZ / BGR / REFBUF CSRs and STATUS |
| `CF_UART` | `0x30001000` | User UART (GPIO 22 TX / 23 RX) |
| `CF_SPI` | `0x30002000` | SPI master (GPIO 16–19) |
| `CF_I2C` | `0x30003000` | I2C master (GPIO 20–21) |
| `CF_TMR32` ×3 | `0x30004000` / `5000` / `6000` | PWM on GPIO 24–26 |
| CAP / GPIO | `0x30007000` | DSM→SRAM burst + GPIO 35–37 |
| `CF_SRAM_1024x32` | `0x30010000` | 1024 × 32-bit capture buffer |

## Catalog IPs

| IP | Version | Role |
| --- | --- | --- |
| [CF_BUF_HIZ](https://github.com/chipfoundry/CF_BUF_HIZ) | 0.2.8 | Sensor input buffer |
| [CF_ADC_DSM20](https://github.com/chipfoundry/CF_ADC_DSM20) | 0.2.2 | Delta-sigma modulator |
| [CF_BGR](https://github.com/chipfoundry/CF_BGR) | 0.2.9 | Bandgap bias / 1.2 V reference |
| [CF_REFBUF](https://github.com/chipfoundry/CF_REFBUF) | 0.2.8 | Buffered `Vout` monitor |
| [CF_UART](https://github.com/chipfoundry/CF_UART) | v2.0.2 | User UART |
| [CF_SPI](https://github.com/chipfoundry/CF_SPI) | v2.0.1 | SPI master |
| [CF_I2C](https://github.com/chipfoundry/CF_I2C) | v2.0.0 | I2C master |
| [CF_TMR32](https://github.com/chipfoundry/CF_TMR32) | v2.1.0 | 32-bit timer / PWM (×3) |
| [CF_SRAM_1024x32](https://github.com/chipfoundry/CF_SRAM_1024x32) | v1.2.3 | 4 KB data SRAM |

```bash
python3 .github/scripts/install_ips.py
```

That clones the tags in `ip/dependencies.json`.

## GPIO

`analog_io[N]` is Caravel GPIO N+7. GPIO 5–6 stay management UART.

| GPIO | Mode | Use |
| --- | --- | --- |
| 7 | analog | BGR `vb2_fast` |
| 8–9 | analog | HIZ `vinp1` / `vinp2` |
| 10 | analog | HIZ `vpwr_core` / `vpwr_acore` |
| 11 | analog | HIZ `vpwrb` / `vpwrb_clk` |
| 12–13 | analog | HIZ `vgnd1` / `vgnd_core` |
| 14 | analog | REFBUF monitor |
| 15 | analog | REFBUF `ng` / `vpwre` |
| 16 | out | SPI SCLK |
| 17 | out | SPI MOSI |
| 18 | in | SPI MISO |
| 19 | out | SPI CSB |
| 20–21 | bidir | I2C SCL / SDA |
| 22 | out | User UART TX |
| 23 | in | User UART RX |
| 24–26 | out | TMR0 / TMR1 / TMR2 PWM0 |
| 27 | analog | HIZ `out2` and DSM negative inputs |
| 28 | analog | DSM `VCM` |
| 29 | analog | DSM `refout` |
| 30 | out | Combined IRQ / capture-done |
| 31 | analog | BGR `dft_curr_in` |
| 32–33 | analog | `vpwr_ext` / `vgnde` (`VGND_DAC`, `vgnde_vnb`) |
| 34 | analog | `vpwr_cp` / `vpwr_cp_dc` |
| 35–37 | bidir | Spare GPIO (`CAP` word 4) |

On-chip nets: HIZ `out1` drives DSM `INP` and `PBUF_INP`.
HIZ `out2` drives DSM `INN` and `PBUF_INN`, and is also
on GPIO 27. `COMBUF_INP` and `COMBUF_INN` are grounded inside `CF_ADC_DSM20`. BGR `Vout` drives `VREF` and `VREFQ`. BGR `ibg_2p375uA`
drives HIZ `iref` and DSM `iin`. BGR `ibg_3uA` drives HIZ `iref_casc`,
DSM `iinc`, and REFBUF `nbias`. HIZ `vcm` shares the DSM `VCM` pad.
`clk_chop`, `lpwr`, `rail`, and `rc` are held low by `io_out[15]`, which
`soc_sys` drives to 0 because GPIO 15 is analog. The wrapper has no stdcell
rails, so a tie cell there would be unpowered. `SUMP_TEST` and
`SUMN_TEST` are left inside the wrapper.

## Harden

`user_project_wrapper` is **elaborated**. Harden digital macros first.
`soc_sys` must be rehardened: `analog_ctrl` is now 207 bits and the ADC
ports are the DSM `dout` byte plus observes.

This wrapper uses official LibreLane 3.0.13. `afe_out1`, `analog_io[20]` (HIZ `out2`), and `analog_io[21]` (`vcm`) route on `ANALOG_WIDE` (0.42 µm met2–met4). Bias, `refout`, `analog_ctrl`, and the power grid stay on the default rule. Antenna repair inserts jumpers only.

```bash
make -C openlane librelane-venv
cf harden soc_sys
cf harden CF_SRAM_1024x32_wb_wrapper
# copy views into gds/ lef/ verilog/gl/ spef/ lib/
cf harden user_project_wrapper --use-docker
```

`cf setup --only-openlane --overwrite` puts shuttle pin CI2511 (LibreLane 2.4.6) back. Do not use it after the 3.0.13 venv exists. `--use-docker` is required: plain `cf harden` prefers Nix and that Nix pin is still CI2511, which has no analog NDR.

`CF_BUF_HIZ` 0.2.8 is the `s8hizbuf_pumptop` wrap, 621 × 440 µm at
(1917.84, 915), 300 µm east of the DSM. `CF_ADC_DSM20` 0.2.2 is
962.27 × 621.385 µm at (655.57, 915), 300 µm above `soc_sys`. BGR and
REFBUF sit at y=1832 so the gap above the DSM is about 296 µm. SRAM
stays at (1300, 115). Chip PDN is `vccd1`/`vssd1` → wrap `vpwr`/`vgnd`.

The first wrapper harden should check DSM wrap pins against parent
met3/met4 and the 180 µm PDN pitch. SAR routing obstructions were not
copied. The old HIZ via2 obstructions were removed with the cell move.

Do not synthesize on top of analog. Do not `cf init` this tree onto the
SAR sensor-SoC project.
