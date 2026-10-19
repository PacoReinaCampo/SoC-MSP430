# FORMATS

| **As/Ad** | **Addressing Mode**    | **Syntax** | **Description**                                                                                                             |
|:----------|:-----------------------|:-----------|:----------------------------------------------------------------------------------------------------------------------------|
| `00/0`    | Register mode          | `Rn`       | Register contents are operand                                                                                               |
| `01/1`    | Indexed mode           | `X(Rn)`    | (Rn + X) points to the operand. X is stored in the next word.                                                               |
| `01/1`    | Symbolic mode          | `ADDR`     | (PC + X) points to the operand. X is stored in the next word. Indexed mode X(PC) is used.                                   |
| `01/1`    | Absolute mode          | `&ADDR`    | The word following the instruction contains the absolute address. X is stored in the next word. Indexed mode X(SR) is used. |
| `10/−`    | Indirect register mode | `@Rn`      | Rn is used as a pointer to the operand.                                                                                     |
| `11/−`    | Indirect autoincrement | `@Rn+`     | Rn is used as a pointer to the operand. Rn is incremented afterwards by 1 for .B instructions and by 2 for .W instructions. |
| `11/−`    | Immediate mode         | `#N`       | The word following the instruction contains the immediate constant N. Indirect autoincrement mode @PC+ is used.             |

**Register Mode**

* **Length**: One or two words
* **Operation**: Move the content of R10 to R11. R10 is not affected.
* **Comment**: Valid for source and destination

**Indexed Mode**

* **Length**: Two or three words
* **Operation**: Move the contents of the source address (contents of R5 + 2) to the destination address (contents of R6 + 6). The source and destination registers (R5 and R6) are not affected. In indexed mode, the program counter is incremented automatically so that program execution continues with the next instruction.
* **Comment**: Valid for source and destination

**Symbolic Mode**

* **Length**: Two or three words
* **Operation**: Move the contents of the source address EDE (contents of PC + X) to the destination address TONI (contents of PC + Y). The words after the instruction contain the differences between the PC and the source or destination addresses. The assembler computes and inserts offsets X and Y automatically. With symbolic mode, the program counter (PC) is incremented automatically so that program execution continues with the next instruction.
* **Comment**: Valid for source and destination

**Absolute Mode**

* **Length**: Two or three words
* **Operation**: Move the contents of the source address EDE to the destination address TONI. The words after the instruction contain the absolute address of the source and destination addresses. With absolute mode, the PC is incremented automatically so that program execution continues with the next instruction.
* **Comment**: Valid for source and destination

**Indirect Register Mode**

* **Length**: One or two words
* **Operation**: Move the contents of the source address (contents of R10) to the destination address (contents of R11). The registers are not modified.
* **Comment**: Valid only for source operand. The substitute for destination operand is 0(Rd).

**Indirect Autoincrement Mode**

* **Length**: One or two words
* **Operation**: Move the contents of the source address (contents of R10) to the destination address (contents of R11). Register R10 is incremented by 1 for a byte operation, or 2 for a word operation after the fetch; it points to the next address without any overhead. This is useful for table processing.
* **Comment**: Valid only for source operand. The substitute for destination operand is 0(Rd) plus second instruction INCD Rd.

**Immediate Mode**

* **Length**: Two or three words. It is one word less if a constant of CG1 or CG2 can be used.
* **Operation**: Move the immediate constant 45h, which is contained in the word following the instruction, to destination address TONI. When fetching the source, the program counter points to the word following the instruction and moves the contents to the destination.
* **Comment**: Valid only for a source operand.
