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
//              Seven Segments                                                //
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

#include "7seg.h"

/*
*********************************************************************************************************
* SEVEN-SEGMENT Digit table
*********************************************************************************************************
*/

INT8U * const DispSegTbl[] = {
  (INT8U *) &DIGIT3,
  (INT8U *) &DIGIT2,
  (INT8U *) &DIGIT1,
  (INT8U *) &DIGIT0
};

/*
*********************************************************************************************************
* ASCII to SEVEN-SEGMENT conversion table
* a
* ------
* f | | b
* | g |
* Note: The segments are mapped as follows: ------
* e | | c
* a b c d e f g | d |
* -- -- -- -- -- -- -- -- ------
* B7 B6 B5 B4 B3 B2 B1 B0
*********************************************************************************************************
*/

const INT8U DispASCIItoSegTbl[] = {// ASCII to SEVEN-SEGMENT conversion table
0x00, // ' '
0x00, // '!', No seven-segment conversion for exclamation point
0x44, // '"', Double quote
0x00, // '#', Pound sign
0x00, // '$', No seven-segment conversion for dollar sign
0x00, // '%', No seven-segment conversion for percent sign
0x00, // '&', No seven-segment conversion for ampersand
0x40, // ''', Single quote
0x9C, // '(', Same as '['
0xF0, // ')', Same as ']'
0x00, // '*', No seven-segment conversion for asterix
0x00, // '+', No seven-segment conversion for plus sign
0x00, // ',', No seven-segment conversion for comma
0x02, // '-', Minus sign
0x00, // '.', No seven-segment conversion for period
0x00, // '/', No seven-segment conversion for slash
0xFC, // '0'
0x60, // '1'
0xDA, // '2'
0xF2, // '3'
0x66, // '4'
0xB6, // '5'
0xBE, // '6'
0xE0, // '7'
0xFE, // '8'
0xF6, // '9'
0x00, // ':', No seven-segment conversion for colon
0x00, // ';', No seven-segment conversion for semi-colon
0x00, // '<', No seven-segment conversion for less-than sign
0x12, // '=', Equal sign
0x00, // '>', No seven-segment conversion for greater-than sign
0xCA, //'?', Question mark
0x00, // '@', No seven-segment conversion for commercial at-sign
0xEE, // 'A'
0x3E, // 'B', Actually displayed as 'b'
0x9C, // 'C'
0x7A, // 'D', Actually displayed as 'd'
0x9E, // 'E'
0x8E, // 'F'
0xBC, // 'G', Actually displayed as 'g'
0x6E, // 'H'
0x60, // 'I', Same as '1'
0x78, // 'J'
0x00, // 'K', No seven-segment conversion
0x1C, // 'L'
0x6E, // 'M', No seven-segment conversion
0x2A, // 'N', Actually displayed as 'n'
0xFC, // 'O', Same as '0'
0xCE, // 'P'
0x00, // 'Q', No seven-segment conversion
0x0A, // 'R', Actually displayed as 'r'
0xB6, // 'S', Same as '5'
0x1E, // 'T', Actually displayed as 't'
0x7C, // 'U'
0x00, // 'V', No seven-segment conversion
0x00, // 'W', No seven-segment conversion
0x00, // 'X', No seven-segment conversion
0x76, // 'Y'
0x00, // 'Z', No seven-segment conversion
0x00, // '['
0x00, // '\', No seven-segment conversion
0x00, // ']'
0x00, // '^', No seven-segment conversion
0x00, // '_', Underscore
0x00, // '`', No seven-segment conversion for reverse quote
0xFA, // 'a'
0x3E, // 'b'
0x1A, // 'c'
0x7A, // 'd'
0xDE, // 'e'
0x8E, // 'f', Actually displayed as 'F'
0xBC, // 'g'
0x2E, // 'h'
0x20, // 'i'
0x78, // 'j', Actually displayed as 'J'
0x00, // 'k', No seven-segment conversion
0x1C, // 'l', Actually displayed as 'L'
0x00, // 'm', No seven-segment conversion
0x2A, // 'n'
0x3A, // 'o'
0xCE, // 'p', Actually displayed as 'P'
0x00, // 'q', No seven-segment conversion
0x0A, // 'r'
0xB6, // 's', Actually displayed as 'S'
0x1E, // 't'
0x38, // 'u'
0x00, // 'v', No seven-segment conversion
0x00, // 'w', No seven-segment conversion
0x00, // 'x', No seven-segment conversion
0x76, // 'y', Actually displayed as 'Y'
0x00 // 'z', No seven-segment conversion
};

/*
*********************************************************************************************************
* DISPLAY ASCII STRING ON SEVEN-SEGMENT DISPLAY
*
* Description: This function is called to display an ASCII string on the seven-segment display.
* Arguments : dig is the position of the first digit where the string will appear:
* 0 for the first seven-segment digit.
* 1 for the second seven-segment digit.
* . . . . . . .
* . . . . . . .
* DISP_N_SS - 1 is the last seven-segment digit.
* s is the ASCII string to display
* Returns : none
* Notes : - Not all ASCII characters can be displayed on a seven-segment display. Consult the
* ASCII to seven-segment conversion table DispASCIItoSegTbl[].
*********************************************************************************************************
*/

void DispStr (INT8U offset, INT8U *s)
{
  int dig        = 0;
  register INT8U* p;
  register INT8U c;
  while (dig < DIGIT_NR) {
    p = DispSegTbl[dig];
    c = *(offset+s);
    *p = DispASCIItoSegTbl[c - 0x20];
    dig++;
    s++;
  }
}
