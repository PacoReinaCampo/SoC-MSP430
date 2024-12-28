# TRAPS

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

## MEMORY

### PU MSP430 MEMORY

## CONTROL

### PU MSP430 DBG

| `Name`          | `Value`                         |
| :-------------- | :------------------------------ |
`CPU_VERSION`     | `3'h2`                          |

:Debug interface: CPU version

| `Name`          | `Value`                         |
| :-------------- | :------------------------------ |
| `DBG_SWBRK_OP`  | `16'h4343`                      |

:Debug interface: Software breakpoint opcode

| `Name`          | `Value`                         |
| :-------------- | :------------------------------ |
| `DBG_UART_BAUD` | `9600`                          |
| `DBG_UART_BAUD` | `19200`                         |
| `DBG_UART_BAUD` | `38400`                         |
| `DBG_UART_BAUD` | `57600`                         |
| `DBG_UART_BAUD` | `115200`                        |
| `DBG_UART_BAUD` | `230400`                        |
| `DBG_UART_BAUD` | `460800`                        |
| `DBG_UART_BAUD` | `576000`                        |
| `DBG_UART_BAUD` | `921600`                        |
| `DBG_UART_BAUD` | `2000000`                       |
| `DBG_DCO_FREQ`  | `20000000`                      |
| `DBG_UART_CNT`  | `DBG_DCO_FREQ/DBG_UART_BAUD)-1` |

:Debug UART interface data rate

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
### PU MSP430 UART
### PU MSP430 WATCHDOG
