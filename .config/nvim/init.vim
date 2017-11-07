call plug#begin('~/.config/nvim/plugged')
Plug 'shiracamus/vim-syntax-x86-objdump-d'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'mustache/vim-mustache-handlebars'
Plug 'kchmck/vim-coffee-script'
Plug '~/.config/nvim/nix'
call plug#end()

let g:solarized_termtrans=1
set background="light"
colorscheme solarized

set hidden autoindent number backspace=indent colorcolumn=100 modeline
set expandtab tabstop=2 shiftwidth=2

let g:airline_theme='solarized'
let g:airline_powerline_fonts=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": ["haskell", "nix"],
  \ "passive_filetypes": [""]
  \}

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
set grepprg=ag\ --nogroup\ --nocolor
" Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
" and .agignovrve. Ignores hidden files by default.
let g:ctrlp_user_command = 'rg %s --files --color never'

map <MiddleMouse> <Nop>
