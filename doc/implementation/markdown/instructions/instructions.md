# INSTRUCTIONS

## MAIN

### PU MSP430 CORE

## FETCH

### PU MSP430 FRONTEND

## DECODE

### PU MSP430 FRONTEND

## EXECUTE

### PU MSP430 EXECUTION

| `Name`       | `Value` |
| :----------- | :------ |
| `INST_SO`    | `0`     |
| `INST_JMP`   | `1`     |
| `INST_TO`    | `2`     |
: Instructions type

| `Name` | `Value` |
| :----- | :------ |
| `JNE`  | `0`     |
| `JEQ`  | `1`     |
| `JNC`  | `2`     |
| `JC`   | `3`     |
| `JN`   | `4`     |
| `JGE`  | `5`     |
| `JL`   | `6`     |
| `JMP`  | `7`     |
: Conditional jump

| `Name`    | `Value` |
| :-------- | :------ |
| `DIR`     | `0`     |
| `IDX`     | `1`     |
| `INDIR`   | `2`     |
| `INDIR_I` | `3`     |
| `SYMB`    | `4`     |
| `IMM`     | `5`     |
| `ABS`     | `6`     |
| `CONST`   | `7`     |
: Addressing modes

| `Name`             | `Value` |
| :----------------- | :------ |
| `I_IRQ_FETCH`      | `3'h0`  |
| `I_IRQ_DONE`       | `3'h1`  |
| `I_DEC`            | `3'h2`  |
| `I_EXT1`           | `3'h3`  |
| `I_EXT2`           | `3'h4`  |
| `I_IDLE`           | `3'h5`  |
: Instruction state machine

| `Name`     | `Value` |
| :--------- | :------ |
| `E_IRQ_0`  | `4'h2`  |
| `E_IRQ_1`  | `4'h1`  |
| `E_IRQ_2`  | `4'h0`  |
| `E_IRQ_3`  | `4'h3`  |
| `E_IRQ_4`  | `4'h4`  |
| `E_SRC_AD` | `4'h5`  |
| `E_SRC_RD` | `4'h6`  |
| `E_SRC_WR` | `4'h7`  |
| `E_DST_AD` | `4'h8`  |
| `E_DST_RD` | `4'h9`  |
| `E_DST_WR` | `4'hA`  |
| `E_EXEC`   | `4'hB`  |
| `E_JUMP`   | `4'hC`  |
| `E_IDLE`   | `4'hD`  |
: Execution state machine

(swapped E_IRQ_0 and E_IRQ_2 values to suppress glitch generation warning from lint tool)

### PU MSP430 ALU

| `Name` | `Value` |
| :----- | :------ |
| `RRC`  | `0`     |
| `SWPB` | `1`     |
| `RRA`  | `2`     |
| `SXT`  | `3`     |
| `PUSH` | `4`     |
| `CALL` | `5`     |
| `RETI` | `6`     |
| `IRQ`  | `7`     |
: Single-operand arithmetic

| `Name` | `Value` |
| :----- | :------ |
| `MOV`  | `0`     |
| `ADD`  | `1`     |
| `ADDC` | `2`     |
| `SUBC` | `3`     |
| `SUB`  | `4`     |
| `CMP`  | `5`     |
| `DADD` | `6`     |
| `BITC` | `7`     |
| `BIC`  | `8`     |
| `BIS`  | `9`     |
| `XORX` | `10`    |
| `ANDX` | `11`    |
: Two-operand arithmetic

### PU MSP430 MULTIPLIER
### PU MSP430 REGISTER-FILE
### PU MSP430 SFR

## MEMORY

### PU MSP430 MEMORY

## CONTROL

### PU MSP430 DBG

### PU MSP430 DBG HWBRK
### PU MSP430 DBG I2C
### PU MSP430 DBG UART

## PERIPHERAL

### PU MSP430 TEMPLATE-08
### PU MSP430 TEMPLATE-16
### PU MSP430 BCM
### PU MSP430 DAC
### PU MSP430 GPIO
### PU MSP430 TA

| `Name`    | `Value` |
| :-------- | :------ |
| `TASSELx` | `9:8`   |
| `TAIDx`   | `7:6`   |
| `TAMCx`   | `5:4`   |
| `TACLR`   | `2`     |
| `TAIE`    | `1`     |
| `TAIFG`   | `0`     |
: Timer A: TACTL Control Register

| `Name`      | `Value` |
| :---------- | :------ |
| ` TACMx`    | `15:14` |
| `TACCISx`   | `13:12` |
| `TASCS`     | `11`    |
| `TASCCI`    | `10`    |
| `TACAP`     | `8`     |
| `TAOUTMODx` | `7:5`   |
| `TACCIE`    | `4`     |
| `TACCI`     | `3`     |
| `TAOUTI`    | `2`     |
| `TACOVI`    | `1`     |
| `TACCIFGI`  | `0`     |
: Timer A: TACCTLx Capture/Compare Control Register

### PU MSP430 UART
### PU MSP430 WATCHDOG
