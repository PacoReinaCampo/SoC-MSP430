# MAIN

| **Component**    |
|:-----------------|
| `pu_msp430_core` |

:Implementation - Main

| **Component**           |
|:------------------------|
| `pu_msp430_and_gate`    |
| `pu_msp430_clock_gate`  |
| `pu_msp430_clock_mux`   |
| `pu_msp430_scan_mux`    |
| `pu_msp430_sync_cell`   |
| `pu_msp430_sync_reset`  |
| `pu_msp430_wakeup_cell` |

:Implementation - Fuse

## PU MSP430 CORE

This 5 bit field can be freely used in order to allowcustom identification of the system through the debug interface

| **Name**       | **Value**  |
|:---------------|:-----------|
| `USER_VERSION` | `5'b00000` |

:Custom user version number

| `Clock` | `Divisions`  | `Constant`      |
|:--------|:-------------|:----------------|
| `MCLK`  | `(/1/2/4/8)` | `MCLK_DIVIDER`  |
| `SMCLK` | `(/1/2/4/8)` | `SMCLK_DIVIDER` |
| `ACLK`  | `(/1/2/4/8)` | `ACLK_DIVIDER`  |

:Clock Dividers

| `Status` | `Low Power Mode`               | `Constant`  |
|:---------|:-------------------------------|:------------|
| `CPUOFF` | `LPM0, LPM1, LPM2, LPM3, LPM4` | `CPUOFF_EN` |
| `SCG0`   | `LPM1, LPM3, LPM4`             | `SCG0_EN`   |
| `SCG1`   | `LPM2, LPM3, LPM4`             | `SCG1_EN`   |
| `OSCOFF` | `LPM4`                         | `OSCOFF_EN` |

:Low Power Modes
