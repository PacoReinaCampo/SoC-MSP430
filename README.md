# SoC-MSP430 WIKI

A System on Chip (SoC) is an integrated circuit that integrates components of a computer system (PU, RAM, GPIO, etc). As they are integrated on a single substrate, SoCs consume much less power and take up much less area than multi-chip designs with equivalent functionality. SoCs are common in the mobile computing, embedded systems and the Internet of Things.

The MSP430 implementation has a 16 bit Microarchitecture, 3 stages data pipeline and an Instruction Set Architecture based on Reduced Instruction Set Computer. Compatible with Wishbone Bus. Only For Researching.


## BASIC SYSTEM CONFIGURATION

|Description                            | Parameter   | Type       | Default
|---------------------------------------| ----------- | ---------- | -------
|Program Memory Size                    | PMEM_SIZE   | integer    | 16384
|Data Memory Size                       | DMEM_SIZE   | integer    | 4096
|Include/Exclude Hardware Multiplier    | MULTIPLYING | std_ulogic | 1
|Include/Exclude Serial Debug interface | DBG_ON      | std_ulogic | 1


## ADVANCED SYSTEM CONFIGURATION (FOR EXPERIENCED USERS)

|Description                                         | Parameter      | Type              | Default
|----------------------------------------------------| -------------- | ----------------- | -------
|Peripheral Memory Space                             | PER_SIZE       | integer           | 512
|Custom user version number                          | USER_VERSION   | std_ulogic_vector | 0
|Include/Exclude Watchdog timer                      | WATCHDOG       | std_ulogic        | 1
|Include/Exclude Non-Maskable-Interrupt support      | NMI_EN         | std_ulogic        | 1
|Number of available IRQs                            | IRQ_16         | std_ulogic        | 1
|                                                    | IRQ_32         | std_ulogic        | 0
|                                                    | IRQ_64         | std_ulogic        | 0
|Input synchronizers                                 | SYNC_NMI       | std_ulogic        | 1
|                                                    | SYNC_CPU_EN    | std_ulogic        | 0
|                                                    | SYNC_DBG_EN    | std_ulogic        | 0
|Defines the debugger CPU_CTL.RST_BRK_EN reset value | DBG_RST_BRK_EN | std_ulogic        | 0


## EXPERT SYSTEM CONFIGURATION (EXPERTS ONLY)

|Description                                       | Parameter          | Type              | Default
|--------------------------------------------------| ------------------ | ----------------- | -------
|Number of hardware breakpoint/watchpoint units    | DBG_HWBRK          | std_ulogic_vector | 1
|Select serial debug interface protocol            | DBG_UART           | std_ulogic        | 0
|                                                  | DBG_I2C            | std_ulogic        | 1
|Enable the I2C broadcast address                  | DBG_I2C_BROADCASTC | std_ulogic        | 1
|Enable/Disable the hardware breakpoint RANGE mode | HWBRK_RANGE        | std_ulogic        | 1
|ASIC version                                      | ASIC               | std_ulogic        | 1


## ASIC SYSTEM CONFIGURATION (EXPERTS/PROFESSIONALS ONLY)

|Description                     | Parameter           | Type              | Default
|--------------------------------| ------------------- | ----------------- | -------
|LOW POWER MODE: SCG             | SCG_EN              | std_ulogic_vector | 1
|FINE GRAINED CLOCK GATING       | CLOCK_GATING        | std_ulogic        | 1
|ASIC CLOCKING                   | ASIC_CLOCKING       | std_ulogic        | 1
|LFXT CLOCK DOMAIN               | LFXT_DOMAIN         | std_ulogic        | 1
|MCLK: Clock Mux                 | MCLK_MUX            | std_ulogic        | 1
|SMCLK: Clock Mux                | SMCLK_MUX           | std_ulogic        | 1
|WATCHDOG: Clock Mux             | WATCHDOG_MUX        | std_ulogic        | 1
|                                | WATCHDOG_NOMUX_ACLK | std_ulogic        | 0
|MCLK: Clock divider             | MCLK_DIVIDER        | std_ulogic        | 1
|SMCLK: Clock divider (/1/2/4/8) | SMCLK_DIVIDER       | std_ulogic        | 1
|ACLK: Clock divider (/1/2/4/8)  | ACLK_DIVIDER        | std_ulogic        | 1
|LOW POWER MODE: CPUOFF          | CPUOFF_EN           | std_ulogic        | 1
|LOW POWER MODE: OSCOFF          | OSCOFF_EN           | std_ulogic        | 1


## SYSTEM CONSTANTS (DO NOT EDIT)

|Description                                         | Parameter           | Type              | Default
|--------------------------------------------------- | ------------------- | ----------------- | -------
|Program Memory Size                                 | PMEM_AWIDTH         | integer           | 13
|Data Memory Size                                    | DMEM_AWIDTH         | integer           | 11
|Peripheral Memory Size                              | PER_AWIDTH          | integer           | 8
|Data Memory Base Adresses                           | DMEM_BASE           | integer           | PER_SIZE
|Program & Data Memory most significant address bit  | PMEM_MSB            | integer           | PMEM_AWIDTH - 1
|                                                    | DMEM_MSB            | integer           | DMEM_AWIDTH - 1
|                                                    | PER_MSB             | integer           | PER_AWIDTH - 1
|Number of available IRQs                            | IRQ_NR              | integer           | 16
|Instructions type                                   | INST_SOC            | integer           | 0
|                                                    | INST_JMPC           | integer           | 1
|                                                    | INST_TOC            | integer           | 2
|Single-operand arithmetic                           | RRC                 | integer           | 0
|                                                    | SWPB                | integer           | 1
|                                                    | RRA                 | integer           | 2
|                                                    | SXTC                | integer           | 3
|                                                    | PUSH                | integer           | 4
|                                                    | CALL                | integer           | 5
|                                                    | RETI                | integer           | 6
|                                                    | IRQX                | integer           | 7
|Conditional jump                                    | JNE                 | integer           | 0
|                                                    | JEQ                 | integer           | 1
|                                                    | JNC                 | integer           | 2
|                                                    | JC                  | integer           | 3
|                                                    | JN                  | integer           | 4
|                                                    | JGE                 | integer           | 5
|                                                    | JL                  | integer           | 6
|                                                    | JMP                 | integer           | 7
|Two-operand arithmetic                              | MOV                 | integer           | 0
|                                                    | ADD                 | integer           | 1
|                                                    | ADDC                | integer           | 2
|                                                    | SUBC                | integer           | 3
|                                                    | SUBB                | integer           | 4
|                                                    | CMP                 | integer           | 5
|                                                    | DADD                | integer           | 6
|                                                    | BITC                | integer           | 7
|                                                    | BIC                 | integer           | 8
|                                                    | BIS                 | integer           | 9
|                                                    | XORX                | integer           | 10
|                                                    | ANDX                | integer           | 11
|Addressing modes                                    | DIR                 | integer           | 0
|                                                    | IDX                 | integer           | 1
|                                                    | INDIR               | integer           | 2
|                                                    | INDIR_I             | integer           | 3
|                                                    | SYMB                | integer           | 4
|                                                    | IMM                 | integer           | 5
|                                                    | ABSC                | integer           | 6
|                                                    | CONST               | integer           | 7
|Instruction state machine                           | I_IRQ_FETCH         | std_ulogic_vector | 000
|                                                    | I_IRQ_DONE          | std_ulogic_vector | 001
|                                                    | I_DEC               | std_ulogic_vector | 010
|                                                    | I_EXT1              | std_ulogic_vector | 011
|                                                    | I_EXT2              | std_ulogic_vector | 100
|                                                    | I_IDLE              | std_ulogic_vector | 101
|Execution state machine                             | E_SRC_AD            | std_ulogic_vector | X5
|                                                    | E_SRC_RD            | std_ulogic_vector | X6
|                                                    | E_SRC_WR            | std_ulogic_vector | X7
|                                                    | E_DST_AD            | std_ulogic_vector | X8
|                                                    | E_DST_RD            | std_ulogic_vector | X9
|                                                    | E_DST_WR            | std_ulogic_vector | XA
|                                                    | E_EXEC              | std_ulogic_vector | XB
|                                                    | E_JUMP              | std_ulogic_vector | XC
|                                                    | E_IDLE              | std_ulogic_vector | XD
|                                                    | E_IRQ_0             | std_ulogic_vector | X2
|                                                    | E_IRQ_1             | std_ulogic_vector | X1
|                                                    | E_IRQ_2             | std_ulogic_vector | X0
|                                                    | E_IRQ_3             | std_ulogic_vector | X3
|                                                    | E_IRQ_4             | std_ulogic_vector | X4
|ALU control signals                                 | ALU_SRC_INV         | integer           | 0
|                                                    | ALU_INC             | integer           | 1
|                                                    | ALU_INC_C           | integer           | 2
|                                                    | ALU_ADD             | integer           | 3
|                                                    | ALU_AND             | integer           | 4
|                                                    | ALU_OR              | integer           | 5
|                                                    | ALU_XOR             | integer           | 6
|                                                    | ALU_DADD            | integer           | 7
|                                                    | ALU_STAT_7          | integer           | 8
|                                                    | ALU_STAT_F          | integer           | 9
|                                                    | ALU_SHIFT           | integer           | 10
|                                                    | EXEC_NO_WR          | integer           | 11
|Debug interface                                     | DBG_UART_WR         | integer           | 18
|                                                    | DBG_UART_BW         | integer           | 17
|Debug interface CPU_CTL register                    | HALT                | integer           | 0
|                                                    | RUN                 | integer           | 1
|                                                    | ISTEP               | integer           | 2
|                                                    | SW_BRK_EN           | integer           | 3
|                                                    | FRZ_BRK_EN          | integer           | 4
|                                                    | RST_BRK_EN          | integer           | 5
|                                                    | CPU_RST             | integer           | 6
|Debug interface BRKx_CTL register                   | BRK_MODE_RD         | integer           | 0
|                                                    | BRK_MODE_WR         | integer           | 1
|                                                    | BRK_EN              | integer           | 2
|                                                    | BRK_I_EN            | integer           | 3
|                                                    | BRK_RANGE           | integer           | 4
|Basic clock module: BCSCTL2 Control Register        | SELMX               | integer           | 7
|                                                    | SELS                | integer           | 3
|MCLK Clock gate                                     | MCLK_CGATE          | std_ulogic        | 1
|SMCLK Clock gate                                    | SMCLK_CGATE         | std_ulogic        | 1
|Debug interface: CPU version                        | CPU_VERSION         | std_ulogic_vector | 010
|Debug interface: Software breakpoint opcode         | DBG_SWBRK_OP        | std_ulogic_vector | X4343
|Debug UART interface auto data synchronization      | DBG_UART_AUTO_SYNC  | std_ulogic        | 1
|Counter width for the debug interface UART          | DBG_UART_XFER_CNT_W | integer           | 16
|Debug UART interface data rate                      | DBG_UART_BAUD       | integer           | 2000000
|                                                    | DBG_DCO_FREQ        | integer           | 20000000
|                                                    | DBG_UART_CNT        | integer           | (DBG_DCO_FREQ / DBG_UART_BAUD) - 1
|                                                    | DBG_UART_CNTB       | std_ulogic_vector | to_unsigned(DBG_UART_CNT, DBG_UART_XFER_CNT_W)
|Debug interface input synchronizer                  | SYNC_DBG_UART_RXD   | std_ulogic        | 1
|MULTIPLIER CONFIGURATION                            | MPY_16X16           | std_ulogic        | 1
