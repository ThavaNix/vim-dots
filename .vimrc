set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'vim-scripts/android.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" execute pathogen#infect()
syntax on
set laststatus=2
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set tabstop=4
set scrolloff=3
set number
set showcmd
set lines=24 columns=80
set splitright
set backspace=indent,eol,start
colorscheme slate
map Y y$

" Jedi displays function call signatures in insert mode in real-time
" highlighting the current argument. The call signatures can be displayed as
" a pop-up in the buffer (set to 1, the default), which has the advantage of
" being easier to refer to, or in Vim's command line aligned with
" the function call (set to 2), which can improve the integrity of Vim's
" undo history.
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = "0"
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#completions_enabled = "1"

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_log_level = 'warning'
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
" let g:ycm_show_diagnostics_ui = 0

" NERDTree
let NERDTreeIgnore = ['\.o', '\~$']

" hy
let g:hy_enable_conceal = 1
setlocal concealcursor=n

" avoid mispress of <SHIFT> when writing and quiting
com -nargs=0 Q q
com -nargs=0 W w
com -nargs=0 Wq wq
com -nargs=0 Wqa wqa

" copy every thing in the file into clipboard
com -nargs=0 CpAll :norm ggVG"+y

" Clear done items in TODO
com -nargs=0 TODOClear :g/\[x\]/ norm dd
com -nargs=0 TODODown :g/\[x\]/ norm ddGp

" Remove trailing space
com -nargs=0 Rmspace :%s/\s*$// | norm 

" mksession command
com -nargs=1 Mks :mksession! ~/.vim/<args>.vim
com -nargs=1 Delsession :!rm ~/.vim/<args>.vim

" edit this file command
com -nargs=0 Vimrc :split ~/.vimrc

" Goto the TODO file
com -nargs=0 TODO :split ~/Desktop/TODO

" ConqueTerm shortened
com -nargs=0 Shell :ConqueTerm bash
com -nargs=0 Python :ConqueTerm python3

" Jedi command
com -nargs=0 Jedi :call Jedi()

autocmd BufRead * call Answer()
autocmd BufRead TODO set syntax=TODO
autocmd BufRead *.ss set filetype=ss
autocmd FileType python call Jedi()

function Jedi()
    set omnifunc=jedi#completions
    set completefunc=jedi#completions
endfunction

function Answer()
    if getline(1) =~? '.*answer.*'
        " || expand("%:t") =~? '.*answer[^.]*\>'
        set syntax=answer
    endif
endfunction

