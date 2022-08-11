rm -f *.tex
rm -f *.pdf

pandoc BOOK.md -s -o SoC-MSP430.tex
pandoc BOOK.md -s -o SoC-MSP430.pdf
