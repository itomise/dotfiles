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
# pnpm end

# oh my zsh theme
export ZSH_THEME="tjkirch"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
