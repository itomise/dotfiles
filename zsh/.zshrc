# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$HOME/.nodebrew/current/bin:$PATH
source $(brew --prefix nvm)/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryota.ito/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ryota.ito/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryota.ito/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ryota.ito/google-cloud-sdk/completion.zsh.inc'; fi

# Dotnet tools 
export PATH="$PATH:/Users/ryota.ito/.dotnet/tools"

# pnpm
export PNPM_HOME="/Users/ryota.ito/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
alias pn=pnpm
# pnpm end

# oh my zsh theme
export ZSH_THEME="tjkirch"

# alias
alias c='clear'
alias ll='ls -alF'
alias la='ls -a'
## cd
alias ..="cd .."
alias blg="cd ~/Documents/project/blog"
alias blgf="cd ~/Documents/project/blog/frontend"
alias blgb="cd ~/Documents/project/blog/backend"
## git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gp='git push'
alias gd='git diff'
alias gf='git fetch'
alias gs='git status'


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
