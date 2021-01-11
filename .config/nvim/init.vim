
" Plug {{{

call plug#begin(stdpath('data') . '/plugged')

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ptzz/lf.vim' | Plug 'rbgrouleff/bclose.vim'
" Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
" Plug 'sedm0784/vim-you-autocorrect'
Plug 'dag/vim-fish'
Plug 'tpope/vim-repeat'
Plug 'prettier/vim-prettier'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-commentary'
Plug 'dylanaraps/wal'
Plug 'tpope/vim-surround'
" Plug 'freitass/todo.txt-vim'
Plug 'liuchengxu/vim-which-key'
" Plug 'sunaku/vim-shortcut'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lifepillar/vim-mucomplete'
Plug 'lervag/vimtex'
Plug 'chriskempson/base16-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'jalvesaq/nvim-r'
Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()
" }}}

" basic settings {{{
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow
set splitright

set noswapfile "no swap files
syntax on
" scroll in the middle
set scrolloff=999

"" formatting
set linebreak " to make vim not split words when breaking a line
set tabstop=4
set shiftwidth=0 "number of spaces used for each step auf autoindent, >>, etc.
set softtabstop=2
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set noautoindent " Match indents on new lines.
"set smartindent " Intellegently dedent / indent new lines based on rules
set breakindent " wrapping text respects indentation

" set or unset cursorline cursorbar
set cursorline

" spelling
" set spelllang=en_us,de_de
" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set nohlsearch " highlight matches of search
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

"disable automatic commenting/comment repition
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"use utf8 encoding
set encoding=utf-8

"wann neue zeile?
set textwidth=999
"set wrapmargin=1

"buffers don't disappear when not active
set hidden

set formatoptions-=cro                  " Stop newline continution of comments
set fileencoding=utf-8                  " The encoding written to file
set clipboard=unnamedplus               " all yanks are also in clipboard register
set autochdir                           " Your working directory will always be the same as your working directory
" use this instead for automatic changing of directory if something breaks with autochdir
" autocmd BufEnter * silent! lcd %:p:h

" }}}

" which-key {{{

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>


" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

""}}}

" mucomplete {{{

" also show menu with just one item
set completeopt+=menuone
" don't automatically insert text from the menu
set completeopt+=noinsert
" only insert the longest common text of the matches
" show information about the currently selected completion
set completeopt+=preview
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#no_mappings = 1
let g:mucomplete#enable_auto_at_startup = 1
" delay in milliseconds
" let g:mucomplete#completion_delay = 500

" manually set complete options, maybe it helps
set complete=.,w,b,u,U,i,d,t

" omni = syntax filetype based
" keyn = local buffer
" uspl = mucomplete spellcheck for the last typed word based on spelllang dictionary
" path = mucomplete spelling function
" ulti = ultisnips
" :h ins-completion

	let g:mucomplete#chains = {
	    \ 'default' : ['omni', 'keyn', 'path', 'dict', 'ulti'],
	    \ 'vim'     : ['path', 'cmd', 'keyn'],
	    \ 'fish' : ['keyn', 'path', 'dict', 'uspl', 'ulti']
	    \ }

" }}}

" colorizer {{{


"enable hex colors colorizer
set termguicolors "required
lua require'colorizer'.setup()

" }}}

" fzf {{{

" add fzf to runtime
set rtp+=~/usr/bin/fzf

" }}}

" ultisnips {{{

" ultisnips settings
" YouCompleteMe and UltiSnips compatibility. (from Greg Hurrel)
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" let g:UltiSnipsExpandTrigger = 'ö'
" let g:UltiSnipsJumpForwardTrigger = 'ö'
" let g:UltiSnipsJumpBackwardTrigger = 'Ö'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

" vim-pandoc {{{

" vim-pandoc
"let g:pandoc#filetypes#pandoc_markdown = 0
" disable automatic spellcheck
let g:pandoc#spell#enabled = 0
" cd to working dir when using pandoc
autocmd FileType pandoc :lchdir %:p:h
" hide concealment for headers in vim-pandoc
 " let g:pandoc#syntax#conceal#blacklist=['atx']
" disable fancy conceal effects
"let g:pandoc#syntax#conceal#use = 0
" disable pandoc foldcolumn (numbers on the side)
let g:pandoc#folding#fdc = 0
let g:pandoc#keyboard#use_default_mappings = 0
let g:pandoc#keyboard#display_motions = 0

" }}}

" lf.vim {{{

"disable standard key mapping.
let g:lf_map_keys = 0

" }}}

" latex {{{

" recognize plaintex as latex - vimtex
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled = 1

" }}}

" keybindings {{{

" bindings for easy split nav
noremap <C-s> <C-w>h
noremap <C-n> <C-w>j
noremap <C-r> <C-w>k
noremap <C-t> <C-w>l

"toggle folds
nnoremap ä za
nnoremap Ä zA

" NEO2 REMAPPINGS
noremap s h
noremap n gj
noremap r gk
noremap t l
" kill
noremap k s
" jump
noremap j n
" hide (replace either one character or enter replace mode)
noremap h r
noremap H R
" that frees up R to be used for redo
noremap R :redo<CR>
" lookup
noremap l t
" join lines
noremap N J

inoremap vf <Esc>
inoremap fv <Esc>
inoremap FV <Esc>
inoremap VF <Esc>

"search next/previous
noremap J N
noremap j n

"S and T (shift+left/right) to move to end or beginning of line.
nnoremap S ^
vnoremap S ^
nnoremap T $
vnoremap T $

nnoremap ( )
nnoremap ) (

" change Y to y$
nnoremap Y y$

" press esc to exit terminal mode
"tnoremap <Esc> <C-\><C-n>

tnoremap <A-s> <C-\><C-N><C-w>h
tnoremap <A-n> <C-\><C-N><C-w>j
tnoremap <A-r> <C-\><C-N><C-w>k
tnoremap <A-t> <C-\><C-N><C-w>l
inoremap <A-s> <C-\><C-N><C-w>h
inoremap <A-n> <C-\><C-N><C-w>j
inoremap <A-r> <C-\><C-N><C-w>k
inoremap <A-t> <C-\><C-N><C-w>l
nnoremap <A-s> <C-w>h
nnoremap <A-n> <C-w>j
nnoremap <A-r> <C-w>k
nnoremap <A-t> <C-w>l
vnoremap <A-s> <C-w>h
vnoremap <A-n> <C-w>j
vnoremap <A-r> <C-w>k
vnoremap <A-t> <C-w>l

"resize using alt keys
noremap <A-up> :resize +1<CR>
noremap <A-down> :resize -1<CR>
noremap <A-left> :vert resize +1<CR>
noremap <A-right> :vert resize -1<CR>

" " }}}

" leader keybindings {{{

""leader
"let mapleader = " "
"let maplocalleader = ","

" spellcheck
" noremap <leader>oe :setlocal spell! spelllang=en_us<CR>
" noremap <leader>od :setlocal spell! spelllang=de_de<CR>
" noremap <leader>oo :setlocal nospell!
noremap <leader>oe :setlocal spelllang=en_us spell<CR>
noremap <leader>od :setlocal spelllang=de_de spell<CR>
noremap <leader>ob :setlocal spelllang=de_de,en_us spell<CR>
noremap <leader>oo :set nospell<CR>

"make enter -> <CR> in normal mode
" noremap <CR> A<CR><Esc>

" space enter or "ö" to make a new line
noremap <leader><CR> A<CR><Esc>
noremap ö A<CR><Esc>

vnoremap <leader>TT :Tabularize /
noremap <leader>Tip :normal vip :Tabularize /
" copy and paste - xclip integration
noremap <leader>yy "+y
noremap <leader>pp "+p
" noremap <leader>yy :!xclip -f -sel clip<CR>
" noremap <leader>pp :-1r !xclip -o -sel clip<CR>
"vnoremap <leader>xy :!xclip -f -sel clip<CR>
"noremap <leader>xp :-1r !xclip -o -sel clip<CR>

"window
" create new split, and switch to it.
noremap <leader>wv <C-w>v
noremap <leader>wh <C-w>s
" equalize size
noremap <leader>w= <C-w>=
noremap <leader>ww <C-w>=
" only one split open
noremap <leader>1 <C-w>o
noremap <leader>wq :close<CR>
noremap <leader>wd :close<CR>
noremap <leader>wx :close<CR>
" change vsplit to hsplit and vice versa
noremap <leader>wmh :ball<CR>
noremap <leader>wmv :vert ball<CR>
"rotate splits
noremap <leader>wr <C-w>r
noremap <leader>wf :Windows<CR>

"tab bindings
noremap <leader>tt :tabnew<CR>
noremap <leader>tn :tabnext<CR>
noremap <leader>tb :tabprevious<CR>
noremap <leader>tc :tabclose<CR>
noremap <leader>tp :tabprevious<CR>
"terminal
" nnoremap <leader>T :terminal<CR>
"compile
" compile markdown and latex and Rscript
" noremap <leader>cp :silent !pandoc % -o output.pdf<CR>
" noremap <leader>cz :silent !zathura output.pdf &<CR>
noremap <leader>cp :silent Pandoc! pdf<CR>
" noremap <leader>cz :silent !zathura output.pdf &<CR>
"nnoremap <leader>cll :!latexmk -pdf %<CR>
"nnoremap <leader>clz :!zathura *.pdf<CR>
noremap <leader>cl :silent !latexmk -pdf %; zathura *.pdf<CR>
noremap <leader>cr :silent !Rscript %

"buffer
noremap <leader>bb :blast<CR>
noremap <leader>bn :bnext<CR>
noremap <leader>bp :bprevious<CR>
noremap <leader>bq :bdelet<CR>
noremap <leader>bx :bdelet<CR>
noremap <leader>bf :Buffers<CR>
nnoremap <Tab> :bnext<CR>

"undo/redo
noremap <leader>r :redo<CR>

"Plug plugin management
noremap <leader>Vi :PlugInstall<CR>
noremap <leader>Vl :PlugList<CR>
noremap <leader>Vc :PlugClean!<CR>

" dotfiles
noremap <leader>.v :edit ~/.config/nvim/init.vim<CR>
noremap <leader>.b :edit ~/.config/bspwm/bspwmrc<CR>
noremap <leader>.f :edit ~/.config/fish/config.fish<CR>
noremap <leader>.s :edit ~/.config/sxhkd/sxhkdrc.x250<CR>
noremap <leader>.. :source ~/.config/nvim/init.vim<CR>

"quit out quickly
" noremap <leader>q :wqall<CR>
" noremap <leader>Q :q!<CR>
noremap <leader>X :q!<CR>
noremap <leader>x :wqall<CR>

"file
" noremap <leader>fs :write<CR>
noremap <leader>fn :edit<space>
noremap <leader>fw :write
noremap <leader>fr :History<CR>
noremap <leader>ff :w<CR>
" noremap <leader>ff :FZF<CR>
noremap <leader>fe :Lf<CR>

"ultisnips
noremap <leader>ue :UltiSnipsEdit<CR>
noremap <leader>us :Snippets<CR>
" view included snippets from vim-Snippets
nnoremap <leader>uv :FZF ~/.local/share/nvim/plugged/vim-snippets/<CR>


"search (fzf)
noremap <leader>sf :FZF<CR>
noremap <leader>ss :FZF<CR>
noremap <leader>sr :History<CR>
noremap <leader>sh :FZF ~/<CR>
noremap <leader>sb :Buffers<CR>
noremap <leader>sw :Windows<CR>
noremap <leader>su :Snippets<CR>
noremap <leader>sc :Commands<CR>
noremap <leader>sH :Helptags<CR>

"help
noremap <leader>hf :Helptags<CR>
" open help split vertically
noremap <leader>hh :vertical help<space>

" }}}

"custom statusline {{{

set laststatus=2
set statusline=
" set statusline+=%.20F         " Path to the file
set statusline+=\ %F
"set statusline+=%.F         " Path to the file
"set statusline+=\ -\      " Separator
set statusline+=\ %y        " Filetype of the file
set statusline+=%=    " other side
"set statusline+=FileType: " Label
"set statusline+=Encoding: " Label
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l    " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines

" }}}

" colorscheme {{{

" important for true colors in neovim
" set termguicolors

 " colorscheme codedark
colorscheme base16-default-dark
" colorscheme base16-tomorrow-night
" colorscheme wal

" }}}

" autocommands {{{

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

"vimrc folding
au BufEnter init.vim setlocal foldmethod=marker
" auto source vimrc
au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC


" " }}}

" nvim-r for R {{{

" let R_in_buffer = 0
"let R_term_cmd = 'alacritty --config-file /home/mo/.config/alacritty/alacritty.x250.yml'
" let R_external_term = 1
" let R_external_term = 'xterm'
let R_objbr_place = 'console,above'
let R_objbr_w  = 60
let R_rconsole_width = 60
let R_assign = 0
" let R_show_args = 0
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

" }}}

" pandoc/markdown {{{

autocmd BufRead,BufNewFile *.md,*.markdown set filetype=pandoc
" autocmd BufRead,BufNewFile *.md,*.rmd,*.rmarkdown,*.markdown set filetype=pandoc
autocmd BufRead,BufNewFile *.rmd set conceallevel=0
autocmd BufRead,BufNewFile *.md set conceallevel=0
autocmd BufRead,BufNewFile *.md set foldlevel=2
autocmd BufRead,BufNewFile *.R set conceallevel=0

" }}}

" filetype indentation and plugin loading {{{

" enables plugin loading based on FileType detection
" filetype plugin indent on
filetype plugin on
" disables identation based on filetype
" filetype indent off

" }}}

" random garbage {{{

" rebind jump to hyperlink in help mode to enter (doesn't work).
autocmd FileType help noremap <CR> <c-]>

" syntax enable                           " Enables syntax highlighing
" set nowrap                              " Display long lines as just one line
" set pumheight=10                        " Makes popup menu smaller
" set ruler              			            " Show the cursor position all the time
" set cmdheight=2                         " More space for displaying messages
" set iskeyword+=-                      	" treat dash separated words as a word text object
" set mouse=a                             " Enable your mouse
" set splitbelow                          " Horizontal splits will automatically be below
" set splitright                          " Vertical splits will automatically be to the right
" set t_Co=256                            " Support 256 colors
" set conceallevel=0                      " So that I can see `` in markdown files
" set tabstop=2                           " Insert 2 spaces for a tab
" set shiftwidth=2                        " Change the number of space characters inserted for indentation
" set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
" set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
" set laststatus=0                        " Always display the status line
" set number                              " Line numbers
" set cursorline                          " Enable highlighting of the current line
" set background=dark                     " tell vim what the background color looks like
" set showtabline=2                       " Always show tabs
" set noshowmode                          " We don't need to see things like -- INSERT -- anymore
" set nobackup                            " This is recommended by coc
" set nowritebackup                       " This is recommended by coc
" set updatetime=300                      " Faster completion
" set timeoutlen=100                      " By default timeoutlen is 1000 ms

" You can't stop me
" cmap w!! w !sudo tee %

" Better nav for omnicomplete
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
" nnoremap <M-j>    :resize -2<CR>
" nnoremap <M-k>    :resize +2<CR>
" nnoremap <M-h>    :vertical resize -2<CR>
" nnoremap <M-l>    :vertical resize +2<CR>

" " Easy CAPS
" inoremap <c-u> <ESC>viwUi
" nnoremap <c-u> viwU<Esc>

" " TAB in general mode will move to text buffer
" nnoremap <TAB> :bnext<CR>
" " SHIFT-TAB will go back
" nnoremap <S-TAB> :bprevious<CR>

" " Alternate way to save
" nnoremap <C-s> :w<CR>
" " Alternate way to quit
" nnoremap <C-Q> :wq!<CR>
" " Use control-c instead of escape
" nnoremap <C-c> <Esc>
" " <TAB>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" " Better window navigation
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" nnoremap <Leader>o o<Esc>^Da
" nnoremap <Leader>O O<Esc>^Da

" }}}

" org-mode (broken) {{{

" doesn't work
" autocmd Filetype org noremap ü @<Plug>OrgToggleFoldingNormal
" autocmd Filetype org noremap Ü <Plug>OrgToggleFoldingReverse

" }}}



" supposed to let you autocomplete citations from title as well not just the bibtex key
" let g:pandoc#biblio#use_bibtool = 1
" sources used for bibtex completion
let g:pandoc#biblio#sources = "gbcltyG"
" doesn't work
let g:pandoc#biblio#bibs = '/home/mo/SynologyDrive/Documents/master/text/master.bib'



nmap <Leader>au <Plug>VimyouautocorrectUndo
nmap <Leader>ae <Plug>:EnableAutocorrect<CR>
nmap <Leader>ad <Plug>:DisableAutocorrect<CR>

" automatically correct last spelling mistake
nnoremap <Leader>aa mx[s1z='x$



  " Use |conceal| for pretty highlighting. Default is 1 for vim version > 7.3
" let g:pandoc#syntax#conceal#use = 0

" don't use conceal on these
" let g:pandoc#syntax#conceal#blacklist = {"titleblock" : "#"}


abbreviate aism authoritarianism
abbreviate Aism Authoritarianism
abbreviate aian authoritarian
abbreviate aians authoritarians
abbreviate Aians Authoritarians
abbreviate Aian Authoritarian
abbreviate aiy authority
abbreviate aiies authorities
abbreviate crv child-rearing values
