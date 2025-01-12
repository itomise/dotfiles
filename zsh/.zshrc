# alias
alias g='git'
alias gs='git status'
alias gsw='git switch'
alias gp='git push'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'


# github cli
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim


# prompt (pure) https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:fetch only_upstream yes
# branch color
zstyle :prompt:pure:path color '#FFF1D0'
zstyle :prompt:pure:git:branch color '#F0C808'
zstyle ':prompt:pure:prompt:success' color '#06AED5'
zstyle ':prompt:pure:prompt:error' color '#DD1C1A'

prompt pure