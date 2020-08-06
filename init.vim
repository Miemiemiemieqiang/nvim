"
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on
set nu
set relativenumber
set incsearch  " 渐进式搜索
set ignorecase " 忽略大小写
set smartcase  " 智能大小写
set hlsearch   " 高亮搜索
set showcmd    " 显示指令
set wildmenu   " 命令补全 
set autochdir  " 设置工作目录为当前目录
set scrolloff=4 "自动滚屏
" 打开运行指令 取消上回合搜索内容的高亮
"exec "nohlsearch" 
let &t_ut=''
set list
set listchars=tab:\|\ ,trail:▫

let mapleader=" "

" 缩进
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" map
noremap <LEADER><CR> :nohlsearch<CR>
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

" Disable the default s key
noremap s <nop>

" U/E keys for 5 times u/e (faster navigation)
noremap <silent> K 5k
noremap <silent> J 5j

" N key: go to the start of the line
noremap <silent> H 0
" I key: go to the end of the line
noremap <silent> L $

call plug#begin('~/.config/nvim/plugged')
"Plug 'ycm-core/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java']}
"Plug 'artur-shaik/vim-javacomplete2', {'for': ['java']}
call plug#end()

"-----Commands----
"PlugInstall [name ...] [#threads] Install plugins
"PlugUpdate [name ...] [#threads]  Install or update plugins
"PlugClean[!]                      Remove unlisted plugins (bang version will clean without prompt)
"PlugUpgrade                       Upgrade vim-plug itself
"PlugStatus                        Check the status of plugins
"PlugDiff                          Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path]     Generate script for restoring the current snapshot of the plugins
"


"------NERDTree------
auto VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"------vim-colorschemes-----
:colorscheme 1989
"
"-----airline------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

"-----ncm2------
"缓存
"autocmd BufEnter * call ncm2#enable_for_buffer()
" 补全模式,具体详情请看下文
"set completeopt=noinsert,menuone,noselect
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

    " Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	endif
endfunc

"auto jump to pre open location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
