"{{{ Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"}}} Vundle

" https://qiita.com/kotashiratsuka/items/dcd1f4231385dc9c78e7
"ファイルタイプに応じて挙動,色を変える
syntax on
filetype indent on

"colorscheme
colorscheme molokai

let mapleader = " "


"OSのクリップボードを使用する
set clipboard+=unnamed

" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup

" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup

" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block

"フォールドを利用する
set foldenable

"set foldmethod=indent
"set foldmethod=marker
set foldmethod=manual

"バックアップを作成しない
set nobackup

"インクリメンタルサーチを有効にする
set incsearch

"大文字小文字を区別しない
set ignorecase

"大文字で検索されたら対象を大文字限定にする
set smartcase

"行末まで検索したら行頭に戻る
set wrapscan

"自動インデントを使用する
set smartindent
set autoindent

"改行時なるべくインデント構造を保つ
set preserveindent
set copyindent

"ステータスラインにコマンドを表示
set showcmd

"括弧の対応をハイライトする
set showmatch

"検索結果をハイライトする
set hlsearch

"ルーラーを表示
set ruler

"行番号を表示
set number

"コマンドラインの高さ
set cmdheight=1

"マクロなどの途中経過を描写しない
set lazyredraw

"目立たせるのは行だけ
if v:version >= 802 && !has('nvim')
	set cursorlineopt=screenline
endif

"絵文字を全角幅で扱う
if v:version >= 800
	set emoji
endif

"ファイル保存する際<EOL>を書き込む
if v:version >= 800
	set fixendofline
endif

"ターミナルで GUI カラーを使う
if v:version >= 800
	set termguicolors
endif

" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells

" コマンドラインの履歴を10000件保存する
set history=10000

"{{{ キー設定

"インサートモードでesc
inoremap jj <Esc>

"矢印キーでは表示行単位で行移動する
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj

"ZZは強制的に書き込む
map ZZ :wq!<CR>

"C-p,C-nでバッファ移動,C-dでバッファを閉じる
nmap <C-P> :bp<CR>
nmap <C-N> :bn<CR>
nmap <C-D> :bd<CR>

"ウインドウ移動はM-hjkl
noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l

"save
nmap <Leader>w :w<CR>
"format
nnoremap <leader>f :%!fmt<CR>

"<M-t>で新規タブ
nmap <M-t> :tabnew<CR>
"M-p,M-nでタブ移動,M-dでタブを閉じる、M-oで開いてるタブ以外全部閉じる
nmap <M-p> :tabp<CR>
nmap <M-n> :tabn<CR>
nmap <M-d> :tabc<CR>
nmap <M-o> :tabo<CR>

"スクロールを高速化する
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"<ESC>
nmap <ESC><ESC> :noh<CR>

"Vモードで選択状態のまま連続インデント
xnoremap < <gv
xnoremap > >gv

"<Leader>uで最後の保存状態まで戻る
nmap <Leader>u :earlier 1f<CR>
"<Leader>rで上とは逆に進む、戻りすぎた時に使用
nmap <Leader>r :later 1f<CR>

" コメントの色を水色
hi Comment ctermfg=3
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2
" yでコピーした時にクリップボードに入る
set guioptions+=a
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect

"Vimを終了しても undo 履歴を復元する
"https://vim-jp.org/vim-users-jp/2010/07/19/Hack-162.html
if has('persistent_undo')
	"set undofile
	"set undodir=~/.vimundo
	function Enablepersistentundo()
		if ! isdirectory( $HOME . "/.vimundo" )
			call mkdir( $HOME . "/.vimundo" )
		endif
		set undodir=~/.vimundo
		set undofile
	endfunction
	"<Leader>unで有効化する、同時にUndo履歴を書き込む、こうすれば編集後履歴を残したい時に使える
	nmap <Leader>un :call Enablepersistentundo()<CR>
	function Clearundohistory()
		let old_undolevels = &undolevels
		set undolevels=-1
		exe "normal a \<BS>\<Esc>"
		let &undolevels = old_undolevels
		unlet old_undolevels
	endfunction
	"<Leader>clでUndo履歴をぶっ飛ばす、persistent_undoを常時有効化してる時にリセットできる
	nmap <Leader>cl :call Clearundohistory()<CR>
endif

"{{{ GUIやOS固有の設定

"ターミナルでマウスを使用できるようにする
if !has('nvim')
	if has ("mouse")
		set mouse=a
		set guioptions+=a
		set ttymouse=urxvt
	endif
endif

"{{{その他

"vimrcを保存時に即時reload
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"vimを開いたときカーソル位置を復元
silent! source $VIMRUNTIME/defaults.vim

"<Leader>nnトグルで絶対行に表示切り替え
if has('unix')
	function Relnum_switch()
		if &relativenumber =='1'
			set norelativenumber
		else
			set relativenumber
		endif
	endfunction
	nmap <Leader>nn :call Relnum_switch()<CR>
endif
