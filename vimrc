"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"   -> Plugins
"   -> General
"   -> UI/UX
"   -> Moves
"   -> Mapping
"   -> Syntastic
"   -> Ultisnips
"   -> Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved, required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

" Tools
Plugin 'ConradIrwin/vim-bracketed-paste' " paste enables transparent pasting into vim
Plugin 'Vimjas/vim-python-pep8-indent' " A nicer Python indentation style for vim.
Plugin 'christoomey/vim-tmux-navigator' " move between Vim panes and tmux splits seamlessly.
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-commentary'

" Snippets and better completion
Plugin 'SirVer/ultisnips' " Track the engine.
Plugin 'honza/vim-snippets' " Snippets are separated from the engine.

" Theme
Plugin 'nlknguyen/papercolor-theme'
Plugin 'rodjek/vim-puppet'
Plugin 'shmup/vim-sql-syntax'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" leader key mapped to space
let mapleader = " "
" Always use vertical diffs
set diffopt+=vertical

set autoindent
set autoread " Reload files changed outside vim
set backspace=eol,start,indent
set expandtab " In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set hlsearch incsearch " highlight search
set ignorecase smartcase " Make search case insensitive, Override if the search pattern contains uppercase characters
set nobackup nowritebackup noswapfile " Disable stupid backup and swap files
set number relativenumber " precede each line with its relative line number.
set path+=** " Provides tab-completion for all file-related tasks, ei :find fo<tab>
set scrolloff=3 sidescrolloff=3
set shiftround " Round indent to multiple of 'shiftwidth'
set splitbelow splitright " Open new split panes to right and bottom, which feels more natural
set tabstop=4 shiftwidth=4
set wildignore=*.pyc
set wildmenu " Display all matching files when we tab complete

" enable highlighting and stripping whitespace on save by default
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" let vim commentary use # to comment in cfg file
autocmd FileType cfg setlocal commentstring=#\ %s
autocmd FileType sql setlocal commentstring=--\ %s

" let vim use relative number on all buffer
autocmd BufEnter * set relativenumber
" set back to normal numbering when leaving buffer
autocmd BufLeave * set number

" eyaml recognize as yaml
autocmd BufNewFile,BufRead *.eyaml setfiletype yaml

" set indentation to 2 space for yaml
autocmd FileType yaml,ruby setlocal ts=2 sts=2 sw=2

"golang use tab
autocmd FileType go set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI/UX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set t_Co=256
set background=light
set cursorline

" Just in case the colorscheme is not available switch back to default
" gracefully
try
    colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

" Status line a.k.a airline
set laststatus=2
" same theme for airline
let g:airline_theme='papercolor'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Indent Guide
let g:indent_guides_enable_on_vim_startup = 1

" Disable autocolor
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=grey
let g:indent_guides_guide_size = 1

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Move
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable arrow
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Indentation setting
" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
"" better indentation
vnoremap < <gv
vnoremap > >gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" use quick jk or kj as esc
imap jk <C-c>
vmap jk <C-c>
cmap jk <C-c>
imap kj <C-c>
vmap kj <C-c>
cmap kj <C-c>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_aggregate_errors = 1 " aggregates errors found by all checkers and displays them.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_echo_current_error=1
let g:syntastic_loc_list_height = 3 " option to specify the height of the location lists

"""""""""""
" sh/bash "
"""""""""""
let g:syntastic_sh_shellcheck_quiet_messages = {
            \ "regex" : ['SC1090'] }

""""""""""
" python "
""""""""""
let g:syntastic_python_checkers = ['flake8']

" Disable python lint error
" C0103: invalid-name
" C0111: missing-docstring
" C0301: Line too long
" C0302: Too many lines in module
" C0412: ungrouped-imports
" E501: line too long
let g:syntastic_python_flake8_quiet_messages = {
            \ "regex": ['C0111', 'C0301', 'C0302', 'C0411', 'E501', 'R\\d\\d\\d\\d']}

""""""""
" Perl "
""""""""
let g:syntastic_perl_checkers = ['perl']

""""""""""
" puppet "
""""""""""
let g:syntastic_puppet_puppetlint_quiet_messages = {
            \ "regex" : ['autoloader_layout', 'documentation'] }

""""""""""
" golang "
""""""""""
let g:syntastic_go_checkers = ['golint']
let g:syntastic_go_golint_quiet_messages = {
            \ "regex" : ['should have comment or be unexported'] }

""""""""
" yaml "
""""""""
let g:syntastic_yaml_checkers = ['yamllint']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For abbreviations read in the following file:
source ~/.vim/abbrev.vim

" Enable spellcheck for markdown and restructuredtext (both english and french)
setlocal spelllang=en,fr

augroup spell
    autocmd Filetype markdown,rst set spell
    autocmd BufRead,BufNewFile  *.[0-9] set spell " Man page
augroup end
