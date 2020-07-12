////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MSP430 CPU                                                    //
//              Software                                                      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2015-2016 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

#include "hardware.h"
#include "7seg.h"

/**
Delay function.
*/
void delay(unsigned int c, unsigned int d) {
  volatile int i, j;
  for (i = 0; i<c; i++) {
    for (j = 0; j<d; j++) {
      nop();
      nop();
    }
  }
}

/**
This one is executed onece a second. it counts seconds, minues, hours - hey
it shoule be a clock ;-)
it does not count days, but i think you'll get the idea.
*/
volatile int irq_counter, offset;

wakeup interrupt (WDT_VECTOR) INT_Watchdog(void) {

  irq_counter++;
  if (irq_counter == 300) {
    irq_counter = 0;
    offset = (offset+1) % 20;
  }
  DispStr  (offset, "OPENMSP430 IN ACTION    ");
}


/**
Main function with some blinking leds
*/
int main(void) {

    int o = 0;
    irq_counter = 0;
    offset      = 0;

    WDTCTL = WDTPW | WDTHOLD;          // Disable watchdog timer

    P1OUT  = 0x00;                     // Port data output
    P2OUT  = 0x00;

    P1DIR  = 0x00;                     // Port direction register
    P2DIR  = 0xff;

    P1IES  = 0x00;                     // Port interrupt enable (0=dis 1=enabled)
    P2IES  = 0x00;
    P1IE   = 0x00;                     // Port interrupt Edge Select (0=pos 1=neg)
    P2IE   = 0x00;

    //WDTCTL = WDTPW | WDTTMSEL | WDTCNTCL;// | WDTIS1  | WDTIS0 ;          // Configure watchdog interrupt

    //IE1 |= 0x01;
    //eint();                            //enable interrupts

    if (CPU_NR==0x0100) { 
      delay(0x000f, 0xffff);
    } 

    while (1) {                         // Main loop, never ends...

      P2OUT = 0x00;
      delay(0x000f, 0xffff);

      P2OUT = 0x01;
      delay(0x000f, 0xffff);

      P2OUT = 0x02;
      delay(0x000f, 0xffff);

      P2OUT = 0x03;
      delay(0x000f, 0xffff);

      P2OUT = 0x02;
      delay(0x000f, 0xffff);

      P2OUT = 0x01;
      delay(0x000f, 0xffff);

    }
}

