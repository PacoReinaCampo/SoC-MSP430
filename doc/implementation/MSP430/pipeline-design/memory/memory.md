# MEMORY

| **Component**      |
|:-------------------|
| `pu_msp430_memory` |

:Implementation - Memory

## PU MSP430 MEMORY

The sum of program, data and peripheral memory spaces must not exceed 64 kB

| `PMEM_SIZE_CUSTOM` |
|:-------------------|
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
|:---------------------|:-------------------|
| `13`                 | `10240`            |

:Custom Program memory (enabled with `PMEM_SIZE_CUSTOM`)

| `DMEM_SIZE_CUSTOM` |
|:-------------------|
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
|:---------------------|:-------------------|
| `13`                 | `10240`            |

:Custom Data memory (enabled with `DMEM_SIZE_CUSTOM`)

| `PMEM`            | `PMEM_AWIDTH` | `PMEM_SIZE` |
|:------------------|:--------------|:------------|
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
|:-------------------|:--------------|:------------|
| `DMEM_SIZE_32_KB`  | `14`          | `32768`     |
| `DMEM_SIZE_24_KB`  | `14`          | `24576`     |
| `DMEM_SIZE_16_KB`  | `13`          | `16384`     |
| `DMEM_SIZE_10_KB`  | `13`          | `10240`     |
| `DMEM_SIZE_8_KB`   | `12`          | `8192`      |
| `DMEM_SIZE_5_KB`   | `12`          | `5120`      |
| `DMEM_SIZE_4_KB`   | `11`          | `4096`      |
| `DMEM_SIZE_2p5_KB` | `11`          | `2560`      |
| `DMEM_SIZE_2_KB`   | `10`          | `2048`      |
| `DMEM_SIZE_1_KB`   | `9`           | `1024`      |
| `DMEM_SIZE_512_B`  | `8`           | `512`       |
| `DMEM_SIZE_256_B`  | `7`           | `256`       |
| `DMEM_SIZE_128_B`  | `6`           | `128`       |

:Data Memory Size
