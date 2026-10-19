# CONTROL

## PU MSP430 DBG

| **Component**         |
|:----------------------|
| `pu_msp430_dbg`       |
| `pu_msp430_dbg_hwbrk` |
| `pu_msp430_dbg_i2c`   |
| `pu_msp430_dbg_uart`  |

:Implementation - Debugger

| **Name**        | **Value** |
|:----------------|:----------|
| `DBG_UART_WR`   | `18`      |
| `DBG_UART_BW`   | `17`      |
| `DBG_UART_ADDR` | `16:11`   |

:Debug interface

| **Name**     | **Value** |
|:-------------|:----------|
| `HALT`       | `0`       |
| `RUN`        | `1`       |
| `ISTEP`      | `2`       |
| `SW_BRK_EN`  | `3`       |
| `FRZ_BRK_EN` | `4`       |
| `RST_BRK_EN` | `5`       |
| `CPU_RST`    | `6`       |

:Debug interface CPU_CTL register

| **Name**     | **Value** |
|:-------------|:----------|
| `HALT_RUN`   | `0`       |
| `PUC_PND`    | `1`       |
| `SWBRK_PND`  | `3`       |
| `HWBRK0_PND` | `4`       |
| `HWBRK1_PND` | `5`       |

:Debug interface CPU_STAT register

| **Name**      | **Value** |
|:--------------|:----------|
| `BRK_MODE_RD` | `0`       |
| `BRK_MODE_WR` | `1`       |
| `BRK_MODE`    | `1:0`     |
| `BRK_EN`      | `2`       |
| `BRK_I_EN`    | `3`       |
| `BRK_RANGE`   | `4`       |

:Debug interface BRKx_CTL register

| **Name**      | **Value** |
|:--------------|:----------|
| `CPU_VERSION` | `3'h2`    |

:Debug interface: CPU version

| **Name**       | **Value**  |
|:---------------|:-----------|
| `DBG_SWBRK_OP` | `16'h4343` |

:Debug interface: Software breakpoint opcode

| **Name**        | **Value**                       |
|:----------------|:--------------------------------|
| `DBG_UART_BAUD` | `9600`                          |
| `DBG_UART_BAUD` | `19200`                         |
| `DBG_UART_BAUD` | `38400`                         |
| `DBG_UART_BAUD` | `57600`                         |
| `DBG_UART_BAUD` | `115200`                        |
| `DBG_UART_BAUD` | `230400`                        |
| `DBG_UART_BAUD` | `460800`                        |
| `DBG_UART_BAUD` | `576000`                        |
| `DBG_UART_BAUD` | `921600`                        |
| `DBG_UART_BAUD` | `2000000`                       |
| `DBG_DCO_FREQ`  | `20000000`                      |
| `DBG_UART_CNT`  | `DBG_DCO_FREQ/DBG_UART_BAUD)-1` |

:Debug UART interface data rate

## PU MSP430 DBG HWBRK
## PU MSP430 DBG I2C
## PU MSP430 DBG UART
