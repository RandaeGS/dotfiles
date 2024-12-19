# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#App aliases
alias vim="nvim"
alias vi="nvim"

eval "$(zoxide init --cmd cd zsh)"

#Exports
export PATH="/home/randaegs/Documents/flutter/bin:$PATH"
export PATH="/home/randaegs/Documents/android-studio/bin:$PATH"
export PATH="/home/randaegs/go/bin:$PATH"
export BROWSER=zen-browser

# Conda lazy loading
conda_init() {
    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    conda config --set auto_activate_base false
}

conda() {
    if [[ ! -v CONDA_EXE ]]; then
        conda_init
    fi
    $CONDA_EXE "$@"
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
