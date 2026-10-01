# DSM sensor SoC

ChipFoundry **DSM sensor SoC** on Caravel: a fork of `cf-sensor-soc` with
`CF_ADC_DSM20` in place of the SAR, plus UART, SPI, I2C, three 32-bit
timers, and 4 KB SRAM for modulator capture.

## Key features

* Differential sensor inputs on GPIO 8–9 (`CF_BUF_HIZ`), with its analog supplies on GPIO 10–13
* Delta-sigma modulator (`CF_ADC_DSM20`) clocked by the Wishbone clock
* Bandgap and buffered 1.2 V reference (`CF_BGR`, `CF_REFBUF`)
* User UART / SPI / I2C / 3× `CF_TMR32` in `soc_sys`
* `CF_SRAM_1024x32` capture buffer at `0x30010000`
* `afe_wb` at `0x30000000` (ID `0xAFE00020`)

## Catalog IPs

| IP | Version | Role |
| --- | --- | --- |
| [CF_BUF_HIZ](https://github.com/chipfoundry/CF_BUF_HIZ) | 0.2.7 | Sensor input buffer |
| [CF_ADC_DSM20](https://github.com/chipfoundry/CF_ADC_DSM20) | 0.2.1 | Delta-sigma modulator |
| [CF_BGR](https://github.com/chipfoundry/CF_BGR) | 0.2.9 | Bandgap bias / 1.2 V reference |
| [CF_REFBUF](https://github.com/chipfoundry/CF_REFBUF) | 0.2.8 | Buffered `Vout` monitor |
| [CF_UART](https://github.com/chipfoundry/CF_UART) | v2.0.2 | User UART |
| [CF_SPI](https://github.com/chipfoundry/CF_SPI) | v2.0.1 | SPI master |
| [CF_I2C](https://github.com/chipfoundry/CF_I2C) | v2.0.0 | I2C master |
| [CF_TMR32](https://github.com/chipfoundry/CF_TMR32) | v2.1.0 | Timer / PWM (×3) |
| [CF_SRAM_1024x32](https://github.com/chipfoundry/CF_SRAM_1024x32) | v1.2.3 | 4 KB SRAM |

## Wishbone map

| Base | Block |
| --- | --- |
| `0x30000000` | `afe_wb` |
| `0x30001000` | UART |
| `0x30002000` | SPI |
| `0x30003000` | I2C |
| `0x30004000` | TMR0 |
| `0x30005000` | TMR1 |
| `0x30006000` | TMR2 |
| `0x30007000` | Capture / spare GPIO |
| `0x30010000` | SRAM |

## GPIO (digital steal)

GPIO 16–26, 30, and 35–37 are user digital. HIZ bias pads that used
those pins on the AFE are not bonded. Sensor, reference, and DSM analog
pads stay analog.

## Resources

* Sibling analog island: [chipfoundry/cf-sensor-afe](https://github.com/chipfoundry/cf-sensor-afe)
