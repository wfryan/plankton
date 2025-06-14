eval "$(starship init zsh)"
alias vi="nvim";
alias shdn="shutdown -h now";
alias milespaper="linux-wallpaperengine --screen-root eDP-1 --fps 5 --scaling fit 1615179492 &"
export HOSTNAME="$(uname -n)"
export HISTSIZE=100000
export SAVEHIST="$HISTSIZE"
export HISTFILE=~/.zsh_history
setopt inc_append_history
