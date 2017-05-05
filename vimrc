execute pathogen#infect()

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai                                          "Auto indent
set si                                          "Smart indent
set nowrap                                      "Do not wrap lines

set softtabstop=4                               " let backspace delete indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=80
let python_highlight_all=1                      " PYTHON
syntax on
" set mouse=a                                   " enable mouse usage
set viewoptions=folds,options,cursor,unix,slash " better unix/windows compatibility
set virtualedit=onemore                         " allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
set showmode                                    " display the current mode

set cursorline                                  " highlight current line
" hi cursorline guibg=\#333333                    " highlight bg color of current line
" hi CursorColumn guibg=\#333333                  " highlight cursor

if has('cmdline_info')
    set ruler                                   " show the ruler
    " set rulerformat=%30(%=\\:b%n%y%m%r%w\\ %l,%c%V\\ %P%) " a ruler on steroids
    set showcmd                                 " show partial commands in status line and
                                                " selected characters/lines in visual mode
endif

"show line numbers
set relativenumber
set number

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
" set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

set backspace=indent,eol,start                  " backspace for dummys
set linespace=0                                 " No extra spaces between rows
set nofoldenable                                " don't fold code on open
set list
set listchars=tab:>.,trail:.,extends:\#,nbsp:.  " Highlight problematic whitespace

" Remove trailing whitespaces and \^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\\\s\\\\+$","","")'))
autocmd BufWritePre * :%s/\s\+$//e              " Remove trailing spaces

" autoresize splits
autocmd VimResized * wincmd =

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

if has('unix')
    set t_Co=256
endif

if &term == "xterm"
    set t_Co=256
endif

" colorscheme monokai
colorscheme buddy
" colorscheme desert
" set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
scriptencoding utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeDirArrows=1
" let g:NERDTreeDirArrowExpandable="+"
" let g:NERDTreeDirArrowCollapsible="-"
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\~$']
let NERDTreeShowBookmarks=1

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive'],[ 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LLFugitive',
    \   'readonly': 'LLReadonly',
    \   'modified': 'LLModified',
    \   'filename': 'LLFilename',
    \   'mode': 'LLMode'
    \ }
    \ }

function! LLMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ lightline#mode() == 'NORMAL' ? 'N' :
        \ lightline#mode() == 'INSERT' ? 'I' :
        \ lightline#mode() == 'VISUAL' ? 'V' :
        \ lightline#mode() == 'V-LINE' ? 'V' :
        \ lightline#mode() == 'V-BLOCK' ? 'V' :
        \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! LLReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "!"
    else
        return ""
    endif
endfunction

function! LLFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LLFilename()
    return ('' != LLReadonly() ? LLReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LLModified() ? ' ' . LLModified() : '')
endfunction

if !has('gui_running')
    set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=250

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Paranthesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

set splitbelow                                      "sp below
set splitright                                      "vs below

" Remap commands to move between split screens
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"SuperTab will dropdown correctly
let g:SuperTabDefaultCompletionType = "<c-n>"

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf

" open file at position last closed at
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif

