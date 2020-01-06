"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"   -> Plugins
"   -> General
"   -> UI/UX
"   -> Moves
"   -> Mapping
"   -> ALE
"   -> Languages Specific
"   -> Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved, required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.local/opt/fzf
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

" Tools
Plugin 'ConradIrwin/vim-bracketed-paste' " paste enables transparent pasting into vim
Plugin 'Vimjas/vim-python-pep8-indent' " A nicer Python indentation style for vim.
Plugin 'christoomey/vim-tmux-navigator' " move between Vim panes and tmux splits seamlessly.
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'w0rp/ale'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'

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
" will not be asked for confirmation before whitespace is stripped when you save the file
let g:strip_whitespace_confirm=0
" only the modified lines will have their trailing whitespace stripped when you save the file
let g:strip_only_modified_lines=1

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
autocmd FileType markdown,yaml,ruby setlocal ts=2 sts=2 sw=2

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
set statusline+=%*

" Stop auto wrap
set formatoptions-=t
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
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_open_list = 1
let b:ale_linters_ignore = ['pylint']
let g:ale_linters = {
            \'python': ['flake8'],
            \'golang': ['goimports'],
            \}

" Disable python lint error
" E501: line too long
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {document-start: disable, line-length: {max: 300}}}"'
" close the loclist window automatically when the buffer is closed
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
let g:ale_list_window_size = 5 " Show 5 lines of errors (default: 10)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GOLANG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable version warning for now as I'm running 8.0.1365
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable spellcheck for markdown and restructuredtext (both english and french)
setlocal spelllang=en,fr

augroup spell
    autocmd Filetype markdown,rst set spell
    autocmd BufRead,BufNewFile  *.[0-9] set spell " Man page
augroup end
