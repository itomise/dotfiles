# alias
alias vim='nvim'
alias vi='nvim'
alias g='git'
alias gs='git status'
alias gsw='git switch'
alias gp='git push'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias gss='git stash push -u'
alias gsp='git stash pop'
alias v='vim .'

# github cli
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim

# prompt (pure) https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:fetch only_upstream yes
# branch color
zstyle :prompt:pure:path color '#FFF1D0'

zstyle ':prompt:pure:prompt:success' color '#06AED5'
zstyle ':prompt:pure:prompt:error' color '#DD1C1A'

prompt pure

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt print_eight_bit

# trash for nvim
export PATH="/opt/homebrew/opt/trash/bin:$PATH"

# fzf history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# cdr自体の設定
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi

# fzf cdr
function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# bun completions
[ -s "/Users/ryota.ito/.bun/_bun" ] && source "/Users/ryota.ito/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.local/bin/env"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/ryota.ito/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
