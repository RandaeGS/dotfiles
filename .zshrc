export ZSH=/usr/share/oh-my-zsh/

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#Command aliases
alias ls="ls -l --color=auto"

#App aliases
alias vim="nvim"
alias vi="nvim"

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export SUDO_EDITOR=/usr/bin/nvim
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
