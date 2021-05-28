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
let &t_ut=''
set list
set listchars=tab:\|\ ,trail:▫

let mapleader=" "

" 缩进
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

"auto jump to pre open location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Press ` to change case (instead of ~)
map ` ~

" Search
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap - Nzz

" mapping
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

" Disable the default s key
noremap s <nop>

" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     h
" < n   i >
"     e
"     v
noremap <silent> h h
noremap <silent> n j
noremap <silent> e k
noremap <silent> i l

" U/E keys for 5 times u/e (faster navigation)
noremap <silent> E 5k
noremap <silent> N 5j

" N key: go to the start of the line
noremap <silent> H 0
" I key: go to the end of the line
noremap <silent> I $

" Insert Key
noremap k i
noremap K I

" ===
" === Tab management
" ===
" Create a new tab with tu
map tu :tabe<CR>
" Move around tabs with tn and ti
map tn :-tabnext<CR>
map te :+tabnext<CR>
" Move the tabs with tmn and tmi
map tmn :-tabmove<CR>
map tmi :+tabmove<CR>

" ===
" === Lazy Git
" ===
noremap <C-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>

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
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

" ===================== Start of Plugin Settings =====================

filetype plugin on
call plug#begin('~/.config/nvim/plugged')

" scheme
Plug 'flazz/vim-colorschemes'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" markdown
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc', {'for': ['gitignore', 'markdown', 'vim-plug']}
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

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

" ===================== Start of Plugin Settings =====================

" ===
" === NERDTree
" ===
" auto VimEnter * NERDTree
" autocmd VimEnter * wincmd p
" let NERDTreeShowBookmarks=1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ===
" === vim-colorschemes
" ===
:colorscheme 1989

" ===
" === airline
" ===
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'



" ===
" === vim-instant-markdown 
" ===
" ref: https://github.com/suan/vim-instant-markdown
" npm -g install instant-markdown-d
"
" Uncomment to override defaults:
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1

" ===
" === Bullets.vim
" ===
" ref: https://github.com/dkarter/bullets.vim
"
"let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]

" ===
" === vim-markdown-toc
" ===
" ref : https://github.com/mzlogin/vim-markdown-toc
"
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" ===================== End of Plugin Settings =====================


" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"
