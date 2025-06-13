eval "$(starship init zsh)"
alias vi="nvim";
alias shdn="shutdown -h now";

export HOSTNAME="$(uname -n)"
export HISTSIZE=100000
export SAVEHIST="$HISTSIZE"
export HISTFILE=~/.zsh_history
setopt inc_append_history
