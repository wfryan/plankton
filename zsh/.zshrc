eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
alias vi="nvim";
alias shdn="shutdown -h now";
alias milespaper="linux-wallpaperengine --screen-root eDP-1 --fps 5 --scaling fit 1615179492 &"
export HOSTNAME="$(uname -n)"
export HISTSIZE=100000
export SAVEHIST="$HISTSIZE"
export HISTFILE=~/.zsh_history
setopt inc_append_history
export PATH="$PATH:/Users/williamryan/Documents/flutter/bin"

alias wt3000="lsof -i tcp:3000"
alias wt8080="lsof -i tcp:8080"
alias wt4200="lsof -i tcp:4200"
alias tm="tmux"

# pnpm
export PNPM_HOME="/Users/williamryan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#source ~/vulkan/1.4.321.1/setup-env.sh
