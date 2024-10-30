# REGISTERS

## MAIN

### PU MSP430 CORE

## FETCH

### PU MSP430 FRONTEND

## DECODE

### PU MSP430 FRONTEND

### PU MSP430 SFR

## EXECUTE

### PU MSP430 EXECUTION
### PU MSP430 ALU

| `Name`        | `Value` |
| :------------ | :------ |
| `ALU_SRC_INV` | `0`     |
| `ALU_INC`     | `1`     |
| `ALU_INC_C`   | `2`     |
| `ALU_ADD`     | `3`     |
| `ALU_AND`     | `4`     |
| `ALU_OR`      | `5`     |
| `ALU_XOR`     | `6`     |
| `ALU_DADD`    | `7`     |
| `ALU_STAT_7`  | `8`     |
| `ALU_STAT_F`  | `9`     |
| `ALU_SHIFT`   | `10`    |
| `EXEC_NO_WR`  | `11`    |

: ALU control signals

### PU MSP430 MULTIPLIER
### PU MSP430 REGISTER-FILE
### PU MSP430 SFR

## MEMORY

### PU MSP430 MEMORY

## CONTROL

### PU MSP430 DBG

| `Name`                | `Value` |
| :-------------------- | :------ |
| `DBG_UART_WR`         | `18`    |
| `DBG_UART_BW`         | `17`    |
| `DBG_UART_ADDR`       | `16:11` |

: Debug interface

| `Name`       | `Value` |
| :----------- | :------ |
| `HALT`       | `0`     |
| `RUN`        | `1`     |
| `ISTEP`      | `2`     |
| `SW_BRK_EN`  | `3`     |
| `FRZ_BRK_EN` | `4`     |
| `RST_BRK_EN` | `5`     |
| `CPU_RST`    | `6`     |

: Debug interface CPU_CTL register

| `Name`       | `Value` |
| :----------- | :------ |
| `HALT_RUN`   | `0`     |
| `PUC_PND`    | `1`     |
| `SWBRK_PND`  | `3`     |
| `HWBRK0_PND` | `4`     |
| `HWBRK1_PND` | `5`     |

: Debug interface CPU_STAT register

| `Name`          | `Value` |
| :-------------- | :------ |
| `BRK_MODE_RD`   | `0`     |
| `BRK_MODE_WR`   | `1`     |
| `BRK_MODE`      | `1:0`   |
| `BRK_EN`        | `2`     |
| `BRK_I_EN`      | `3`     |
| `BRK_RANGE`     | `4`     |

: Debug interface BRKx_CTL register

### PU MSP430 DBG HWBRK
### PU MSP430 DBG I2C
### PU MSP430 DBG UART

## PERIPHERAL

### PU MSP430 TEMPLATE-08
### PU MSP430 TEMPLATE-16
### PU MSP430 BCM

| `Name`  | `Value` |
| :------ | :------ |
| `DIVAx` | `5:4`   |

: Basic clock module: BCSCTL1 Control Register

| `Name`  | `Value` |
| :------ | :------ |
| `SELMx` | `7`     |
| `DIVMx` | `5:4`   |
| `SELS`  | `3`     |
| `DIVSx` | `2:1`   |

: Basic clock module: BCSCTL2 Control Register

### PU MSP430 DAC
### PU MSP430 GPIO
### PU MSP430 TA
### PU MSP430 UART
### PU MSP430 WATCHDOG
