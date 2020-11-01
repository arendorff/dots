#!/bin/fish

for file in *.pdf
    pdftotext $file
