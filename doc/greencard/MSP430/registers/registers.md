# REGISTERS

**Program Counter (PC)**

The 16-bit program counter (PC/R0) points to the next instruction to be executed. Each instruction uses an even number of bytes (two, four, or six), and the PC is incremented accordingly. Instruction accesses in the 64-KB address space are performed on word boundaries, and the PC is aligned to even addresses.

**Stack Pointer (SP)**

The stack pointer (SP/R1) is used by the CPU to store the return addresses of subroutine calls and interrupts. It uses a predecrement, postincrement scheme. In addition, the SP can be used by software with all instructions and addressing modes.

**Status Register (SR)**

The status register (SR/R2), used as a source or destination register, can be used in the register mode only addressed with word instructions. The remaining combinations of addressing modes are used to support the constant generator.

**Constant Generator Registers CG1 and CG2**

Six commonly-used constants are generated with the constant generator registers R2 and R3, without requiring an additional 16-bit word of program code.

**General−Purpose Registers R4 - R15**

The twelve registers, R4−R15, are general-purpose registers. All of these registers can be used as data registers, address pointers, or index values and can be accessed with byte or word instructions.
