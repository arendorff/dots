#!/usr/bin/fish


# get path of all pdf files in current directories and subdirectories
set files (fd -a -t f '^.*.pdf$' . | sed '/ /d')

echo $files

# get DOIs from every pdf using pdftotext and remove unnecessary characters with sed
set doi (
    for path in $files
        pdftotext $path - | grep -i "doi.*10." | sed '
            s/.*10\./10\./g;
            s/ .*$//g;
            /10\..../!d;
            s/\.$//g;
            s/)$//g' | uniq

    end
)

echo $doi | sed 's/)//g'



# curl bibtex entry from crossref.org using doi
 for item in $doi
     curl --silent "https://api.crossref.org/works/$item/transform/application/x-bibtex"
     # new line between entries
     echo "
     "
 end

 #| grep "Resource not found" && echo ERROR

 # | sed 's/Resource not found.//g'

            # s/.*10\./10\./g;
            # s/ .*$//g;
            # s/[^a-z,0-9]$//g' | uniq
