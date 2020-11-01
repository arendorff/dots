#!/bin/fish

for i in *.pdf
    pdftotext -q $i - | grep -i "$argv"
end
