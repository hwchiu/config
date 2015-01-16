set encoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,latin1
set fileencoding=utf-8
set termencoding=utf-8
set number              "line number
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set ai    			"automatically indentation
syntax on 			"color
set tabstop=4            "Replace tab as  four spaces
set cursorline              " cursor line
set t_Co=256                " support 256 color
set backspace=2
set nocompatible
set shiftwidth=4
let python_highlight_all = 1

filetype plugin indent on

" Nerdtree
"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

set background=dark "background color
nnoremap <silent> <F5> :NERDTree<CR>
nnoremap <Esc>1 gt1
nnoremap <Esc>2 gt2
nnoremap <Esc>3 gt3
nnoremap <Esc>4 gt4
nnoremap <Esc>5 gt5
nnoremap <Esc>6 gt6
nnoremap <Esc>7 gt7
nnoremap <Esc>8 gt8

"TagList
"F1 turn off/on window
let Tlist_Exit_OnlyWindow =1 "Automatically close when there are only Taglist window in the screen
let Tlist_Show_Menu=1


let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'marijnh/tern_for_vim'


" for yum
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
let g:ycm_key_invoke_completion = ''
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/','!~/*']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" for white space
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=darkblue guibg=bule

syntax enable
colorscheme monokai
