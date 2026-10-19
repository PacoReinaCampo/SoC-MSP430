# PERIPHERAL

| **Component**          |
|:-----------------------|
| `pu_msp430_template08` |
| `pu_msp430_template16` |
| `pu_msp430_bcm`        |
| `pu_msp430_dac`        |
| `pu_msp430_gpio`       |
| `pu_msp430_ta`         |
| `pu_msp430_uart`       |
| `pu_msp430_watchdog`   |

:Implementation - Peripherals

The original MSP430 architecture map the peripherals from 0x0000 to 0x01FF (i.e. 512B of the memory space). The following defines allow you to expand this space up to 32 kB (i.e. from 0x0000 to 0x7fff). As a consequence, the data memory mapping will be shifted up and a custom linker script will therefore be required by the GCC compiler.

| `PER_SIZE_CUSTOM` |
|:------------------|
| `PER_SIZE_32_KB`  |
| `PER_SIZE_16_KB`  |
| `PER_SIZE_8_KB`   |
| `PER_SIZE_4_KB`   |
| `PER_SIZE_2_KB`   |
| `PER_SIZE_1_KB`   |
| `PER_SIZE_512_B`  |

:Peripheral Memory Size

| `PER_CUSTOM_AWIDTH` | `PER_CUSTOM_SIZE` |
|:--------------------|:------------------|
| `8`                 | `512`             |

:Custom Peripheral memory (enabled with `PER_SIZE_CUSTOM`)

| `PER`            | `PER_AWIDTH` | `PER_SIZE` |
|:-----------------|:-------------|:-----------|
| `PER_SIZE_32_KB` | `14`         | `32768`    |
| `PER_SIZE_16_KB` | `13`         | `16384`    |
| `PER_SIZE_8_KB`  | `12`         | `8192`     |
| `PER_SIZE_4_KB`  | `11`         | `4096`     |
| `PER_SIZE_2_KB`  | `10`         | `2048`     |
| `PER_SIZE_1_KB`  | `9`          | `1024`     |
| `PER_SIZE_512_B` | `8`          | `512`      |

:Peripheral Memory Size

## PU MSP430 TEMPLATE-08
## PU MSP430 TEMPLATE-16
## PU MSP430 BCM

| **Name** | **Value** |
|:---------|:----------|
| `DIVAx`  | `5:4`     |

:Basic clock module: BCSCTL1 Control Register

| **Name** | **Value** |
|:---------|:----------|
| `SELMx`  | `7`       |
| `DIVMx`  | `5:4`     |
| `SELS`   | `3`       |
| `DIVSx`  | `2:1`     |

:Basic clock module: BCSCTL2 Control Register
## PU MSP430 DAC
## PU MSP430 GPIO
## PU MSP430 TA

| **Name**  | **Value** |
|:----------|:----------|
| `TASSELx` | `9:8`     |
| `TAIDx`   | `7:6`     |
| `TAMCx`   | `5:4`     |
| `TACLR`   | `2`       |
| `TAIE`    | `1`       |
| `TAIFG`   | `0`       |

:Timer A: TACTL Control Register

| **Name**    | **Value** |
|:------------|:----------|
| ` TACMx`    | `15:14`   |
| `TACCISx`   | `13:12`   |
| `TASCS`     | `11`      |
| `TASCCI`    | `10`      |
| `TACAP`     | `8`       |
| `TAOUTMODx` | `7:5`     |
| `TACCIE`    | `4`       |
| `TACCI`     | `3`       |
| `TAOUTI`    | `2`       |
| `TACOVI`    | `1`       |
| `TACCIFGI`  | `0`       |

:Timer A: TACCTLx Capture/Compare Control Register

## PU MSP430 UART
## PU MSP430 WATCHDOG
