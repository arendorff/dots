#!/bin/fish



touch ~/scripts/"$argv".fish

echo '#!/bin/fish' > ~/scripts/"$argv".fish

chmod +x ~/scripts/"$argv".fish

nvim ~/scripts/"$argv".fish
