# FORMATS

| **As/Ad** | **Addressing Mode**      | **Syntax** | **Description**                                                                                                              |
|:----------|:-------------------------|:-----------|:-----------------------------------------------------------------------------------------------------------------------------|
| `00/0`    | `Register mode`          | `Rn`       | `Register contents are operand`                                                                                              |
| `01/1`    | `Indexed mode`           | `X(Rn)`    | `(Rn + X) points to the operand. X is stored in the next word`                                                               |
| `01/1`    | `Symbolic mode`          | `ADDR`     | `(PC + X) points to the operand. X is stored in the next word. Indexed mode X(PC) is used`                                   |
| `01/1`    | `Absolute mode`          | `&ADDR`    | `The word following the instruction contains the absolute address. X is stored in the next word. Indexed mode X(SR) is used` |
| `10/−`    | `Indirect register mode` | `@Rn`      | `Rn is used as a pointer to the operand`                                                                                     |
| `11/−`    | `Indirect autoincrement` | `@Rn+`     | `Rn is used as a pointer to the operand. Rn is incremented afterwards by 1 for .B instructions and by 2 for .W instructions` |
| `11/−`    | `Immediate mode`         | `#N`       | `The word following the instruction contains the immediate constant N. Indirect autoincrement mode @PC+ is used`             |