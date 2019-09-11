call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'sebdah/vim-delve'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

let mapleader = " "

let g:ctrlp_map = ''
nnoremap <c-p> :FZF<cr>

map <leader>c :nohl<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

set background=dark

set number
set relativenumber
set list lcs=tab:\┊\ 

set autoread
set noswapfile
"set colorcolumn=81

"--------------------
" Plugin: deoplete
"--------------------
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
"let g:deoplete#sources#go#source_importer = 1
"let g:deoplete#sources#go#builtin_objects = 1
"let g:deoplete#sources#go#unimported_packages = 0

"--------------------
" Plugin: vim-airline
"--------------------
let g:airline_powerline_fonts = 0
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ''

"--------------------
" Language: Go
"--------------------
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au FileType go nmap <leader>gr <Plug>(go-run)

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
