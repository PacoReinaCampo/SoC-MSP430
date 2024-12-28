# ARCHITECTURE

## MAIN

| `Component`       |
| :---------------- |
| `pu_msp430_core`  |

:Implementation - Main

| `Component`             |
| :---------------------- |
| `pu_msp430_and_gate`    |
| `pu_msp430_clock_gate`  |
| `pu_msp430_clock_mux`   |
| `pu_msp430_scan_mux`    |
| `pu_msp430_sync_cell`   |
| `pu_msp430_sync_reset`  |
| `pu_msp430_wakeup_cell` |

:Implementation - Fuse

### PU MSP430 CORE

This 5 bit field can be freely used in order to allowcustom identification of the system through the debug interface

| `Name`         | `Value`    |
| :------------- | :--------- |
| `USER_VERSION` | `5'b00000` |

:Custom user version number

| `Clock` | `Divisions`  | `Constant`      |
| :------ | :----------- | :-------------- |
| `MCLK`  | `(/1/2/4/8)` | `MCLK_DIVIDER`  |
| `SMCLK` | `(/1/2/4/8)` | `SMCLK_DIVIDER` |
| `ACLK`  | `(/1/2/4/8)` | `ACLK_DIVIDER`  |

:Clock Dividers

| `Status` | `Low Power Mode`               | `Constant`  |
| :------- | :----------------------------- | :---------- |
| `CPUOFF` | `LPM0, LPM1, LPM2, LPM3, LPM4` | `CPUOFF_EN` |
| `SCG0`   | `LPM1, LPM3, LPM4`             | `SCG0_EN`   |
| `SCG1`   | `LPM2, LPM3, LPM4`             | `SCG1_EN`   |
| `OSCOFF` | `LPM4`                         | `OSCOFF_EN` |

:Low Power Modes

## FETCH

| `Component`          |
| :------------------- |
| `pu_msp430_frontend` |

:Implementation - Fetch

### PU MSP430 FRONTEND

## DECODE

| `Component`          |
| :------------------- |
| `pu_msp430_frontend` |

:Implementation - Decode

### PU MSP430 FRONTEND

## EXECUTE

| `Component`               |
| :------------------------ |
| `pu_msp430_execution`     |
| `pu_msp430_alu`           |
| `pu_msp430_multiplier`    |
| `pu_msp430_register_file` |
| `pu_msp430_sfr`           |

:Implementation - Execute

### PU MSP430 EXECUTION
### PU MSP430 ALU
### PU MSP430 MULTIPLIER
### PU MSP430 REGISTER-FILE
### PU MSP430 SFR

## MEMORY

| `Component`        |
| :----------------- |
| `pu_msp430_memory` |

:Implementation - Memory

### PU MSP430 MEMORY

The sum of program, data and peripheral memory spaces must not exceed 64 kB

| `PMEM_SIZE_CUSTOM` |
| :----------------- |
| `PMEM_SIZE_59_KB`  |
| `PMEM_SIZE_55_KB`  |
| `PMEM_SIZE_54_KB`  |
| `PMEM_SIZE_51_KB`  |
| `PMEM_SIZE_48_KB`  |
| `PMEM_SIZE_41_KB`  |
| `PMEM_SIZE_32_KB`  |
| `PMEM_SIZE_24_KB`  |
| `PMEM_SIZE_16_KB`  |
| `PMEM_SIZE_12_KB`  |
| `PMEM_SIZE_8_KB`   |
| `PMEM_SIZE_4_KB`   |
| `PMEM_SIZE_2_KB`   |
| `PMEM_SIZE_1_KB`   |

:Program Memory Size

| `PMEM_CUSTOM_AWIDTH` | `PMEM_CUSTOM_SIZE` |
| :------------------- | :----------------- |
| `13`                 | `10240`            |

:Custom Program memory (enabled with `PMEM_SIZE_CUSTOM`)

| `DMEM_SIZE_CUSTOM` |
| :----------------- |
| `DMEM_SIZE_32_KB`  |
| `DMEM_SIZE_24_KB`  |
| `DMEM_SIZE_16_KB`  |
| `DMEM_SIZE_10_KB`  |
| `DMEM_SIZE_8_KB`   |
| `DMEM_SIZE_5_KB`   |
| `DMEM_SIZE_4_KB`   |
| `DMEM_SIZE_2p5_KB` |
| `DMEM_SIZE_2_KB`   |
| `DMEM_SIZE_1_KB`   |
| `DMEM_SIZE_512_B`  |
| `DMEM_SIZE_256_B`  |
| `DMEM_SIZE_128_B`  |

:Data Memory Size

| `DMEM_CUSTOM_AWIDTH` | `DMEM_CUSTOM_SIZE` |
| :------------------- | :----------------- |
| `13`                 | `10240`            |

:Custom Data memory (enabled with `DMEM_SIZE_CUSTOM`)

## CONTROL

### PU MSP430 DBG

| `Component`           |
| :-------------------- |
| `pu_msp430_dbg`       |
| `pu_msp430_dbg_hwbrk` |
| `pu_msp430_dbg_i2c`   |
| `pu_msp430_dbg_uart`  |

:Implementation - Debugger

### PU MSP430 DBG HWBRK
### PU MSP430 DBG I2C
### PU MSP430 DBG UART

## PERIPHERAL

| `Component`            |
| :--------------------- |
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
| :---------------- |
| `PER_SIZE_32_KB`  |
| `PER_SIZE_16_KB`  |
| `PER_SIZE_8_KB`   |
| `PER_SIZE_4_KB`   |
| `PER_SIZE_2_KB`   |
| `PER_SIZE_1_KB`   |
| `PER_SIZE_512_B`  |

:Peripheral Memory Size

| `PER_CUSTOM_AWIDTH` | `PER_CUSTOM_SIZE` |
| :------------------ | :---------------- |
| `8`                 | `512`             |

:Custom Peripheral memory (enabled with `PER_SIZE_CUSTOM`)

### PU MSP430 TEMPLATE-08
### PU MSP430 TEMPLATE-16
### PU MSP430 BCM
### PU MSP430 DAC
### PU MSP430 GPIO
### PU MSP430 TA
### PU MSP430 UART
### PU MSP430 WATCHDOG
