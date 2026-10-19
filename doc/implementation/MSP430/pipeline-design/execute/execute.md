# EXECUTE

| **Component**             |
|:--------------------------|
| `pu_msp430_execution`     |
| `pu_msp430_alu`           |
| `pu_msp430_multiplier`    |
| `pu_msp430_register_file` |
| `pu_msp430_sfr`           |

:Implementation - Execute

## PU MSP430 EXECUTION

| **Name**   | **Value** |
|:-----------|:----------|
| `INST_SO`  | `0`       |
| `INST_JMP` | `1`       |
| `INST_TO`  | `2`       |

:Instructions type

| **Name** | **Value** |
|:---------|:----------|
| `JNE`    | `0`       |
| `JEQ`    | `1`       |
| `JNC`    | `2`       |
| `JC`     | `3`       |
| `JN`     | `4`       |
| `JGE`    | `5`       |
| `JL`     | `6`       |
| `JMP`    | `7`       |

:Conditional jump

| **Name**  | **Value** |
|:----------|:----------|
| `DIR`     | `0`       |
| `IDX`     | `1`       |
| `INDIR`   | `2`       |
| `INDIR_I` | `3`       |
| `SYMB`    | `4`       |
| `IMM`     | `5`       |
| `ABS`     | `6`       |
| `CONST`   | `7`       |

:Addressing modes

| **Name**      | **Value** |
|:--------------|:----------|
| `I_IRQ_FETCH` | `3'h0`    |
| `I_IRQ_DONE`  | `3'h1`    |
| `I_DEC`       | `3'h2`    |
| `I_EXT1`      | `3'h3`    |
| `I_EXT2`      | `3'h4`    |
| `I_IDLE`      | `3'h5`    |

:Instruction state machine

| **Name**   | **Value** |
|:-----------|:----------|
| `E_IRQ_0`  | `4'h2`    |
| `E_IRQ_1`  | `4'h1`    |
| `E_IRQ_2`  | `4'h0`    |
| `E_IRQ_3`  | `4'h3`    |
| `E_IRQ_4`  | `4'h4`    |
| `E_SRC_AD` | `4'h5`    |
| `E_SRC_RD` | `4'h6`    |
| `E_SRC_WR` | `4'h7`    |
| `E_DST_AD` | `4'h8`    |
| `E_DST_RD` | `4'h9`    |
| `E_DST_WR` | `4'hA`    |
| `E_EXEC`   | `4'hB`    |
| `E_JUMP`   | `4'hC`    |
| `E_IDLE`   | `4'hD`    |

:Execution state machine

(swapped E_IRQ_0 and E_IRQ_2 values to suppress glitch generation warning from lint tool)

## PU MSP430 ALU

| **Name**      | **Value** |
|:--------------|:----------|
| `ALU_SRC_INV` | `0`       |
| `ALU_INC`     | `1`       |
| `ALU_INC_C`   | `2`       |
| `ALU_ADD`     | `3`       |
| `ALU_AND`     | `4`       |
| `ALU_OR`      | `5`       |
| `ALU_XOR`     | `6`       |
| `ALU_DADD`    | `7`       |
| `ALU_STAT_7`  | `8`       |
| `ALU_STAT_F`  | `9`       |
| `ALU_SHIFT`   | `10`      |
| `EXEC_NO_WR`  | `11`      |

:ALU control signals

| **Name** | **Value** |
|:---------|:----------|
| `RRC`    | `0`       |
| `SWPB`   | `1`       |
| `RRA`    | `2`       |
| `SXT`    | `3`       |
| `PUSH`   | `4`       |
| `CALL`   | `5`       |
| `RETI`   | `6`       |
| `IRQ`    | `7`       |

:Single-operand arithmetic

| **Name** | **Value** |
|:---------|:----------|
| `MOV`    | `0`       |
| `ADD`    | `1`       |
| `ADDC`   | `2`       |
| `SUBC`   | `3`       |
| `SUB`    | `4`       |
| `CMP`    | `5`       |
| `DADD`   | `6`       |
| `BITC`   | `7`       |
| `BIC`    | `8`       |
| `BIS`    | `9`       |
| `XORX`   | `10`      |
| `ANDX`   | `11`      |

:Two-operand arithmetic

## PU MSP430 MULTIPLIER
## PU MSP430 REGISTER-FILE
## PU MSP430 SFR

| `IRQ`    | `IRQ_NR`    |
|:---------|:------------|
| `IRQ_16` | `IRQ_NR 16` |
| `IRQ_32` | `IRQ_NR 32` |
| `IRQ_64` | `IRQ_NR 64` |

:Number of available IRQs
