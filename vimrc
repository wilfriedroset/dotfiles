" =====================================
" ===           Plugins             ===
" =====================================

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
Plugin 'dense-analysis/ale'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Bundle 'edkolev/tmuxline.vim'

" Theme & Code display
Plugin 'glench/vim-jinja2-syntax'
Plugin 'kaicataldo/material.vim'
Plugin 'nlknguyen/papercolor-theme'
Plugin 'rodjek/vim-puppet'
Plugin 'shmup/vim-sql-syntax'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'hashivim/vim-terraform'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" =====================================
" ===           General             ===
" =====================================

" leader key mapped to space
let mapleader = " "
" Always use vertical diffs
set diffopt+=vertical

set expandtab " In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set hlsearch " highlight search
set ignorecase smartcase " Make search case insensitive, Override if the search pattern contains uppercase characters
set nobackup nowritebackup noswapfile " Disable stupid backup and swap files
set number relativenumber " precede each line with its relative line number.
set path+=** " Provides tab-completion for all file-related tasks, ei :find fo<tab>
set scrolloff=3 sidescrolloff=3
set shiftround " Round indent to multiple of 'shiftwidth'
set splitbelow splitright " Open new split panes to right and bottom, which feels more natural
set tabstop=4 shiftwidth=4
set wildignore=*.pyc

" let vim commentary use # to comment in cfg file
autocmd FileType cfg setlocal commentstring=#\ %s
autocmd FileType sql setlocal commentstring=--\ %s

" let vim use relative number on all buffer
autocmd BufEnter * set relativenumber
" set back to normal numbering when leaving buffer
autocmd BufLeave * set number

" yaml specific configuration
" eyaml recognize as yaml
autocmd BufNewFile,BufRead *.eyaml setfiletype yaml
autocmd FileType markdown,yaml,ruby setlocal ts=2 sts=2 sw=2 tw=0

autocmd Filetype gitcommit setlocal spell textwidth=72

" golang specific configuration
autocmd FileType go set noexpandtab

" =====================================
" ===           UI/UX               ===
" =====================================

" Color scheme
set t_Co=256
set background=light
set cursorline

" Just in case the colorscheme is not available switch back to default
" gracefully
try
    colorscheme material
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

" same theme for airline
let g:airline_powerline_fonts = 1
let g:airline_theme='material'
set statusline+=%#warningmsg#
set statusline+=%*

" TmuxlineSnapshot! ~/.tmux/themes/same-as-vim.tmux
let g:tmuxline_preset = {
      \'a'    : '#{session_name}',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I#F', '#W'],
      \'options': {
        \'status-justify': 'left',}
        \}

" Stop auto wrap
set formatoptions-=t
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1


" =====================================
" ===           Move                ===
" =====================================

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

" =====================================
" ===           Map                 ===
" =====================================

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Manage split
map <Leader>tr <C-w>r
" Change 2 split windows from vertical <> horizontal
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K


" =====================================
" ===           Spell Check         ===
" =====================================

" Enable spellcheck for markdown and restructuredtext (both english and french)
setlocal spelllang=en,fr

augroup spell
    autocmd Filetype markdown,rst set spell
    autocmd BufRead,BufNewFile  *.[0-9] set spell " Man page
augroup end

" =====================================
" ===    Plugins Configuration      ===
" =====================================

" ===     dense-analysis/ale        ===
let b:ale_linters_ignore = ['pylint']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_list_window_size = 5 " Show 5 lines of errors (default: 10)
let g:ale_open_list = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
            \'python': ['flake8'],
            \'golang': ['goimports'],
            \}

let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {document-start: disable, line-length: {max: 300}, braces: disable, commas: disable}}"'

" close the loclist window automatically when the buffer is closed
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" ===        fatih/vim-go           ===
" Disable version warning for now as I'm running 8.0.1365
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"

" === ntpeters/vim-better-whitespace ===
let g:better_whitespace_enabled=1 " enable highlighting and stripping whitespace on save by default
let g:strip_only_modified_lines=1 " only the modified lines will have their trailing whitespace stripped when you save the file
let g:strip_whitespace_confirm=0 " will not be asked for confirmation before whitespace is stripped when you save the file
let g:strip_whitespace_on_save=1

" === nathanaelkane/vim-indent-guides ===
let g:indent_guides_auto_colors = 0 " Disable autocolor
let g:indent_guides_enable_on_vim_startup = 1 " Indent Guide
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=grey

" ===  christoomey/vim-tmux-navigator ===
let g:tmux_navigator_disable_when_zoomed = 1 " Disable tmux navigator when zooming the Vim pane

" ===   preservim/nerdtree          ===
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

