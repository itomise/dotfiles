# dotfiles プロジェクト概要

このドキュメントは dotfiles プロジェクトの構成と設定の概要をまとめたものです。

## プロジェクト構成

```
dotfiles/
├── iterm2/
│   └── com.googlecode.iterm2.plist  # iTerm2設定ファイル
├── nvim/
│   ├── init.lua                     # Neovim メイン設定ファイル
│   ├── lazy-lock.json               # インストール済みプラグインのバージョン管理
│   └── lua/
│       ├── custom/                  # カスタムプラグイン設定ディレクトリ
│       │   └── plugins/
│       │       └── init.lua         # カスタムプラグイン設定（現在は空）
│       └── kickstart/               # 基本プラグイン設定
│           ├── health.lua
│           └── plugins/             # 各プラグインの設定
│               ├── autopairs.lua
│               ├── debug.lua
│               ├── gitsigns.lua
│               ├── indent_line.lua
│               ├── lint.lua
│               └── neo-tree.lua
├── obsidian/
│   └── .obsidian.vimrc              # ObsidianのVimモード設定
├── tig/
│   └── .tigrc                       # Gitテキストインターフェース設定
├── vim/
│   ├── .vimrc                       # Vim設定ファイル
│   └── colors/
│       └── molokai.vim              # カラースキーム
├── vscode_backup/
│   ├── keybindings.json             # VSCodeキーバインド
│   └── settings.json                # VSCode設定
└── zsh/
    └── .zshrc                       # Zシェル設定ファイル
```

## Neovim 設定の詳細

Neovimの設定は「kickstart.nvim」をベースにしています。これは完全な設定ディストリビューションではなく、カスタマイズのための出発点として設計されています。

### 基本設定

- スペースキーをリーダーキーとして使用
- 行番号表示
- マウスサポート有効
- クリップボード連携
- 自動インデント
- 検索ハイライト
- Tokyo Night カラースキーム

### インストール済みプラグイン

#### コア機能
- **lazy.nvim**: プラグイン管理
- **vim-sleuth**: インデント自動検出
- **gitsigns.nvim**: Git統合（変更箇所の表示、ハンク操作など）
- **which-key.nvim**: キーバインドヘルプ
- **telescope.nvim**: ファジーファインダー（ファイル検索、グレップ、ヘルプなど）

#### LSP関連
- **nvim-lspconfig**: LSP設定
- **mason.nvim**: LSPサーバー管理
- **mason-lspconfig.nvim**: Mason と LSPConfig の連携
- **mason-tool-installer.nvim**: ツール自動インストール
- **fidget.nvim**: LSPステータス表示
- **cmp-nvim-lsp**: LSP補完
- **lazydev.nvim**: Lua LSP設定

#### コード編集
- **conform.nvim**: コードフォーマット
- **nvim-cmp**: 自動補完
- **LuaSnip**: スニペットエンジン
- **cmp_luasnip**: Luasnipとcmpの連携
- **nvim-treesitter**: 構文解析と高度なハイライト

#### UI関連
- **tokyonight.nvim**: カラースキーム
- **todo-comments.nvim**: TODOコメントのハイライト
- **mini.nvim**: 小さな機能集（ステータスライン、サラウンド、テキストオブジェクトなど）

#### オプションプラグイン（コメントアウト状態）
- **nvim-dap**: デバッグ機能
- **indent-blankline.nvim**: インデントライン表示
- **nvim-lint**: リンター
- **nvim-autopairs**: 自動括弧閉じ
- **neo-tree.nvim**: ファイルエクスプローラー

### 主要なキーマップ

#### 基本操作
- `<Space>`: リーダーキー
- `<Esc>`: ハイライト解除
- `<C-h/j/k/l>`: ウィンドウ間移動

#### ファイル操作
- `<leader>f`: バッファフォーマット
- `<leader><leader>`: バッファリスト
- `<leader>/`: 現在のバッファ内をファジー検索

#### Telescope
- `<leader>sh`: ヘルプタグ検索
- `<leader>sk`: キーマップ検索
- `<leader>sf`: ファイル検索
- `<leader>sg`: グレップ検索
- `<leader>sd`: 診断検索
- `<leader>sr`: 前回の検索を再開

#### LSP
- `gd`: 定義へジャンプ
- `gr`: 参照を検索
- `gI`: 実装へジャンプ
- `<leader>D`: 型定義へジャンプ
- `<leader>ds`: ドキュメントシンボル検索
- `<leader>ws`: ワークスペースシンボル検索
- `<leader>rn`: 変数名リネーム
- `<leader>ca`: コードアクション
- `<leader>th`: インラインヒントの切り替え

#### Git
- `]c`/`[c`: 次/前のGit変更へ移動
- `<leader>hs`: ハンクをステージ
- `<leader>hr`: ハンクをリセット
- `<leader>hb`: 行のblame表示
- `<leader>hd`: diffを表示

## Zsh 設定の詳細

### エイリアス
```zsh
alias g='git'
alias gs='git status'
alias gsw='git switch'
alias gp='git push'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
```

### 環境変数
```zsh
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim
```

### プロンプト設定
- **Pure prompt** を使用
- Git stashの表示
- Git fetchはupstreamのみ
- カスタムカラー設定

### 履歴設定
- 履歴ファイル: `~/.zsh_history`
- 履歴サイズ: 100000
- 重複コマンドの削除
- スペースで始まるコマンドは履歴に残さない

### fzf 連携
- `Ctrl+r`: 履歴検索
- `Ctrl+q`: ディレクトリ移動履歴検索

## Vim 設定の詳細

### プラグイン管理
- **Vundle** を使用
- 主要プラグイン:
  - vim-fugitive: Git操作
  - sparkup: HTML展開

### 基本設定
- **molokai** カラースキーム
- スペースをリーダーキーとして使用
- クリップボード連携
- バックアップファイルなし
- 行番号表示
- インクリメンタルサーチ
- 大文字小文字を区別しない検索（スマートケース）
- 自動インデント

### インデント設定
- タブをスペースに展開
- インデント幅: 2スペース
- タブ幅: 2スペース

### キーマッピング
- `jj`: インサートモードでEscapeキー
- `<Leader>w`: ファイル保存
- `<C-P>`/`<C-N>`: バッファ切り替え
- `<C-D>`: バッファを閉じる
- `<M-h/j/k/l>`: ウィンドウ間移動
- `<M-t>`: 新規タブ
- `<M-p>`/`<M-n>`: タブ切り替え
- `<ESC><ESC>`: 検索ハイライト解除
- `<Leader>u`: 最後の保存状態まで戻る
- `<Leader>r`: 変更を進める
- `<Leader>nn`: 相対行番号の切り替え

## その他の設定ファイル

### iTerm2
- `com.googlecode.iterm2.plist`: iTerm2の設定ファイル

### Obsidian
- `.obsidian.vimrc`: ObsidianでのVimモード設定

### Tig
- `.tigrc`: Gitテキストインターフェースの設定

### VSCode
- `settings.json`: VSCodeの設定
- `keybindings.json`: VSCodeのキーバインド設定
