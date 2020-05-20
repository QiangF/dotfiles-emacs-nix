call plug#begin('~/.config/nvim/plugged')
"--------------------
" Dev stuff
"--------------------
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
"Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
"Plug 'bling/vim-airline'
"Plug 'dense-analysis/ale'
"Plug 'sebdah/vim-delve'
"Plug 'tpope/vim-surround'
"Plug 'Yggdroot/indentLine'
"Plug 'fatih/vim-go'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'calviken/vim-gdscript3'
Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'mattn/vim-lsp-settings'

"--------------------
" School stuff
"--------------------
"Plug 'vimwiki/vimwiki'
"Plug 'lervag/vimtex'
"Plug 'junegunn/goyo.vim'
"Plug 'sirver/ultisnips'
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
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
"set colorcolumn=81

"--------------------
" Plugin: vimwiki
"--------------------
let g:vimwiki_list = [{'path': '~/school'}]
let g:vimwiki_conceallevel=0
autocmd FileType vimwiki setlocal conceallevel=2
autocmd FileType vimwiki setlocal concealcursor=nc
autocmd FileType vimwiki highlight clear SpellBad
autocmd FileType vimwiki highlight SpellBad cterm=underline
autocmd FileType vimwiki setlocal spell spelllang=en_us
autocmd FileType vimwiki inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd FileType vimwiki setlocal wrap
autocmd FileType vimwiki setlocal linebreak
autocmd FileType vimwiki noremap <silent> k gk
autocmd FileType vimwiki noremap <silent> j gj
autocmd FileType vimwiki noremap <silent> 0 g0
autocmd FileType vimwiki noremap <silent> $ g$
autocmd FileType vimwiki setlocal showbreak=»\ 

"--------------------
" Plugin: vimtex
"--------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
autocmd FileType tex setlocal conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_progname = 'nvr'
autocmd FileType tex setlocal spell
autocmd FileType tex setlocal spelllang=en_us
autocmd FileType tex inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd FileType tex nnoremap <leader>a :VimtexCompile<cr>
"call deoplete#custom#var('omni', 'input_patterns', {
"      \ 'tex': g:vimtex#re#deoplete
"      \})

"--------------------
" Plugin: ultisnips
"--------------------
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"--------------------
" Plugin: deoplete
"--------------------
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#unimported_packages = 1

"--------------------
" Plugin: asyncomplete
"--------------------
"let g:asyncomplete_auto_popup = 0
set completeopt+=preview
"let g:asyncomplete_log_file = expand('asyncomplete.log')

"--------------------
" Plugin: lsp
"--------------------
let g:lsp_settings_filetype_csharp = 'omnisharp-lsp'
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/lsp.log')

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
" Plugin: ale
"--------------------
let g:ale_linters = { 'cs': ['OmniSharp'] }

"--------------------
" Language: yaml
"--------------------

"--------------------
" Language: csharp
"--------------------
let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_server_path = '~/.cache/omnisharp-vim/omnisharp-roslyn'
let g:OmniSharp_server_stdio = 1
au FileType cs set noexpandtab
au FileType cs set shiftwidth=4
au FileType cs set softtabstop=4
au FileType cs set tabstop=4
au FileType cs set number
au FileType cs set relativenumber
au FileType cs set list lcs=tab:\┊\ 

"--------------------
" Language: Go
"--------------------
au FileType go let g:deoplete#enable_at_startup = 1
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
au FileType go set number
au FileType go set relativenumber
au FileType go set list lcs=tab:\┊\ 
au FileType go nmap <leader>gr <Plug>(go-run)
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

autocmd BufRead,BufNewFile /home/purplg/code/go/src/purplg.com/gw2overlay/* nmap <F2> :!./run.sh<CR>
