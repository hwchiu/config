set encoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,latin1
set fileencoding=utf-8
set termencoding=utf-8
set number              " 行號
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set ai                  " 自動縮排
syntax on               " 色彩標示

set tabstop=4               " tab使用四個空白取代
set shiftwidth=4            " 縮排空白數，要搭配set cin使用
set cin
set cursorline              " 該行的線
set t_Co=256                " 支援 256 色
set textwidth=0
set backspace=2 		    "按下backspace會後退，道行首後會刪除到前一行
set showmatch			    "顯示括號配對情況
set nocompatible			"用vim的特性去運行，捨棄vi的特性

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
 

set background=dark                 "背景顏色
colorscheme darkblue
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
"F1 開關視窗
nnoremap <silent> <F1> :TlistToggle<CR>  
let Tlist_Exit_OnlyWindow = 1 		"視窗剩下Taglist的時候自動關閉
let Tlist_Use_Right_Window=1 
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
Bundle 'clang-complete'
Bundle 'https://github.com/vim-scripts/taglist.vim'
