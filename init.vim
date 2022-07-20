set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Code runner
map <F8> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!gcc % -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
exec "!g++ % -o %<"
exec "!time ./%<"
elseif &filetype == 'java'
exec "!javac %"
exec "!time java -cp %:p:h %:t:r"
elseif &filetype == 'sh'
exec "!time bash %"
elseif &filetype == 'html'
exec "!firefox % &"
elseif &filetype == 'go'
exec "!go build %<"
exec "!time go run %"
elseif &filetype == 'mkd'
exec "!~/.vim/markdown.pl % > %.html &"
exec "!firefox %.html &"
endif
endfunc
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>


call plug#begin()
	" Appearance 
	Plug 'vim-airline/vim-airline'
	Plug 'ryanoasis/vim-devicons'
	Plug 'patstockwell/vim-monokai-tasty'
	Plug 'dracula/vim'

	" Utilities
	Plug 'sheerun/vim-polyglot'
	Plug 'jiangmiao/auto-pairs'
	Plug 'ap/vim-css-color'
	Plug 'preservim/nerdtree'
	Plug 'majutsushi/tagbar'
	Plug 'kien/ctrlp.vim'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	" Completion / linters / formatters
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'plasticboy/vim-markdown'
	Plug 'stephpy/vim-php-cs-fixer'
	Plug 'pantharshit00/vim-prisma'

	" Git
	Plug 'airblade/vim-gitgutter'

	" Window chooser
	Plug 't9md/vim-choosewin'
	" Automatically sort python imports
	Plug 'fisadev/vim-isort'
	" Highlight matching html tags
	Plug 'valloric/MatchTagAlways'
	" Generate html in a simple way
	Plug 'mattn/emmet-vim'
	" Git integration
	Plug 'tpope/vim-fugitive'
	" Git/mercurial/others diff icons on the side of the file lines
	Plug 'mhinz/vim-signify'

	" Indent text object
	Plug 'michaeljsmith/vim-indent-object'
	" Indentation based movements
	Plug 'jeetsukumaran/vim-indentwise'
	" Better language packs
	Plug 'sheerun/vim-polyglot'

	" Python autocompletion
	" Plug 'deoplete-plugins/deoplete-jedi'
" Completion from other opened files	
	Plug 'Shougo/context_filetype.vim'
	" Just to add the python go-to-definition and similar features, autocompletion
	" from this plugin is disabled
	Plug 'davidhalter/jedi-vim'
	Plug 'neomake/neomake'
	" Automatically close parenthesis, etc
	Plug 'Townk/vim-autoclose'

	" Keymap shorcuts
	" Start screen
	Plug 'mhinz/vim-startify'

	" flutter stuff
	Plug 'nvim-lua/plenary.nvim'
	Plug 'akinsho/flutter-tools.nvim'
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'thosakwe/vim-flutter'
	Plug 'natebosch/vim-lsc'
	Plug 'natebosch/vim-lsc-dart'
call plug#end()

" Syntax
filetype plugin indent on
syntax on

" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent

" MAPPINGS
" tab navigation mappings
map tt :tabnew 
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e


" True color if available
let term_program = $TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
	set termguicolors
else
	if $TERM !=? 'xterm-256color'
		set termguicolors
	endif
endif

" Color scheme and themes
let t_Co = 256

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    colorscheme dracula
		hi Normal guibg=NONE ctermbg=NONE
else
    colorscheme delek
		hi Normal guibg=NONE ctermbg=NONE
endif

" Airline
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#airline_powerline_fonts = 1


" Italics
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"

" Tagbar -----------------------------

" toggle tagbar display
map <F2> :DartAnalysisServerDiagnostics<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1


let NERDTreeShowHidden = 0

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Tasklist ------------------------------

" show pending tasks list
map <F1> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
" autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 1

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Jedi-vim ------------------------------
let g:jedi#completions_enabled = 1

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" CTRLP: Ignore based on gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Language server stuff
let g:python3_host_prog = '/usr/bin/python3'
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Leader
let mapleader = ','

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
" nnoremap <F6> :sp<CR>:terminal<CR>

nnoremap <silent> <C-t> :call <SID>toggle_terminal()<CR>
function! s:toggle_terminal() abort
  let l:w = bufwinnr('term://.*/\d\+:bash') " find window having bash terminal
  if l:w > 0 " if found
    execute l:w . 'close'
  else 
    split term://bash " start a new bash terminal in a split
  endif
endfunction

"" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-q> :close <CR>

" Show highlight groups
map <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" flutter hotkeys
"nnoremap <leader>fa :FlutterRun<cr>
"nnoremap <leader>fq :FlutterQuit<cr>
"nnoremap <leader>fr :FlutterHotReload<cr>
"nnoremap <leader>fR :FlutterHotRestart<cr>
"nnoremap <leader>fD :FlutterVisualDebug<cr>
"nnoremap <leader>fl :FlutterEmulatorsLaunch Nexus One API 22<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gf <Plug>(coc-definition)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>fc  :CocList --input=flutter commands<CR>
nmap <leader>fe  :CocCommand flutter.emulators<CR>
nmap <leader>fr  :CocCommand flutter.run<CR>
nmap <leader>fq  :CocCommand flutter.dev.quit<CR>
nmap <leader>fh  :CocCommand flutter.dev.hotRestart<CR>
nmap <leader>fl  :CocCommand flutter.dev.openDevLog<CR>
