# DATA FORMATS

## MAIN

### PU MSP430 CORE

## FETCH

### PU MSP430 FRONTEND

## DECODE

### PU MSP430 FRONTEND

## EXECUTE

### PU MSP430 EXECUTION
### PU MSP430 ALU
### PU MSP430 MULTIPLIER
### PU MSP430 REGISTER-FILE
### PU MSP430 SFR

| `IRQ`   | `IRQ_NR`    |
| :------ | :---------- |
| `IRQ_16`| `IRQ_NR 16` |
| `IRQ_32`| `IRQ_NR 32` |
| `IRQ_64`| `IRQ_NR 64` |

:Number of available IRQs

## MEMORY

### PU MSP430 MEMORY

| `PMEM`            | `PMEM_AWIDTH` | `PMEM_SIZE` |
| :---------------- | :------------ | :---------- |
| `PMEM_SIZE_59_KB` | `15`          | `60416`     |
| `PMEM_SIZE_55_KB` | `15`          | `56320`     |
| `PMEM_SIZE_54_KB` | `15`          | `55296`     |
| `PMEM_SIZE_51_KB` | `15`          | `52224`     |
| `PMEM_SIZE_48_KB` | `15`          | `49152`     |
| `PMEM_SIZE_41_KB` | `15`          | `41984`     |
| `PMEM_SIZE_32_KB` | `14`          | `32768`     |
| `PMEM_SIZE_24_KB` | `14`          | `24576`     |
| `PMEM_SIZE_16_KB` | `13`          | `16384`     |
| `PMEM_SIZE_12_KB` | `13`          | `12288`     |
| `PMEM_SIZE_8_KB`  | `12`          | `8192`      |
| `PMEM_SIZE_4_KB`  | `11`          | `4096`      |
| `PMEM_SIZE_2_KB`  | `10`          | `2048`      |
| `PMEM_SIZE_1_KB`  | `9`           | `1024`      |

:Program Memory Size

| `PMEM`             | `DMEM_AWIDTH` | `DMEM_SIZE` |
| :----------------- | :------------ | :---------- |
| `DMEM_SIZE_32_KB`  | `14`          | `32768`     |
| `DMEM_SIZE_24_KB`  | `14`          | `24576`     |
| `DMEM_SIZE_16_KB`  | `13`          | `16384`     |
| `DMEM_SIZE_10_KB`  | `13`          | `10240`     |
| `DMEM_SIZE_8_KB`   | `12`          | `8192`      |
| `DMEM_SIZE_5_KB`   | `12`          | `5120`      |
| `DMEM_SIZE_4_KB`   | `11`          | `4096`      |
| `DMEM_SIZE_2p5_KB` | `11`          | `2560`      |
| `DMEM_SIZE_2_KB`   | `10`          | `2048`      |
| `DMEM_SIZE_1_KB`   |  `9`          | `1024`      |
| `DMEM_SIZE_512_B`  |  `8`          | `512`       |
| `DMEM_SIZE_256_B`  |  `7`          | `256`       |
| `DMEM_SIZE_128_B`  |  `6`          | `128`       |

:Data Memory Size

## CONTROL

### PU MSP430 DBG

### PU MSP430 DBG HWBRK
### PU MSP430 DBG I2C
### PU MSP430 DBG UART

## PERIPHERAL

| `PER`            | `PER_AWIDTH` | `PER_SIZE` |
| :--------------- | :----------- | :--------- |
| `PER_SIZE_32_KB` |  `14`        | `32768`    |
| `PER_SIZE_16_KB` |  `13`        | `16384`    |
| `PER_SIZE_8_KB`  |  `12`        | `8192`     |
| `PER_SIZE_4_KB`  |  `11`        | `4096`     |
| `PER_SIZE_2_KB`  |  `10`        | `2048`     |
| `PER_SIZE_1_KB`  |  `9`         | `1024`     |
| `PER_SIZE_512_B` |  `8`         | `512`      |

:Peripheral Memory Size

### PU MSP430 TEMPLATE-08
### PU MSP430 TEMPLATE-16
### PU MSP430 BCM
### PU MSP430 DAC
### PU MSP430 GPIO
### PU MSP430 TA
### PU MSP430 UART
### PU MSP430 WATCHDOG
