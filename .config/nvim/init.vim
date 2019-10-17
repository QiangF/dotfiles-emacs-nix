call plug#begin('~/.config/nvim/plugged')
"--------------------
" Dev stuff
"--------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'sebdah/vim-delve'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'calviken/vim-gdscript3'

"--------------------
" School stuff
"--------------------
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'
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
" Plugin: vimwiki
"--------------------
let g:vimwiki_list = [{'path': '~/wiki/'}]
"
"--------------------
" Plugin: Vimtex
"--------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
"set conceallevel=1
let g:tex_conceal='adbmg'

"--------------------
" Plugin: UltiSnips
"--------------------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']

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
" Language: yaml
"--------------------
au FileType yaml set noexpandtab
au FileType yaml set shiftwidth=4
au FileType yaml set softtabstop=4
au FileType yaml set tabstop=4

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

autocmd BufRead,BufNewFile /home/purplg/code/go/src/purplg.com/gw2overlay/* nmap <F2> :!./run.sh<CR>
