#!/bin/fish


for i in *.pdf
    pdftotext -q $i
end
