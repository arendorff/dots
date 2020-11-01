#!/usr/bin/fish



set files (fd -a -t f '^.*.pdf$' .)


set doi (for path in $files
    pdfinfo $path | grep -i doi | sed 's/^.*doi:/ /'
end)


echo $doi | sed 's/  / /'


for item in $doi
    doi2bib $item
end


