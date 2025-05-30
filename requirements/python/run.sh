###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Architecture                                                     ##
##              QueenField                                                       ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2019-2020 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

python3 -B library/bfm/ahb4/peripheral_design.py
python3 -B library/bfm/apb4/peripheral_design.py
python3 -B library/bfm/axi4/peripheral_design.py
python3 -B library/bfm/bb/peripheral_design.py
python3 -B library/bfm/tl/peripheral_design.py
python3 -B library/bfm/wb/peripheral_design.py
python3 -B library/core/ahb4/peripheral_design.py
python3 -B library/core/apb4/peripheral_design.py
python3 -B library/core/axi4/peripheral_design.py
python3 -B library/core/bb/peripheral_design.py
python3 -B library/core/tl/peripheral_design.py
python3 -B library/core/wb/peripheral_design.py
python3 -B library/pu/ahb4/peripheral_design.py
python3 -B library/pu/apb4/peripheral_design.py
python3 -B library/pu/axi4/peripheral_design.py
python3 -B library/pu/bb/peripheral_design.py
python3 -B library/pu/tl/peripheral_design.py
python3 -B library/pu/wb/peripheral_design.py
python3 -B library/soc/ahb4/peripheral_design.py
python3 -B library/soc/apb4/peripheral_design.py
python3 -B library/soc/axi4/peripheral_design.py
python3 -B library/soc/bb/peripheral_design.py
python3 -B library/soc/tl/peripheral_design.py
python3 -B library/soc/wb/peripheral_design.py
