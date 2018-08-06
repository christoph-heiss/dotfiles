#
# ~/.bashrc
#

# If not running interactively, do nothing
[[ $- != *i* ]] && return

[[ -s ~/.bash_colors ]] && source ~/.bash_colors

export PATH="$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/local/bin:$HOME/.gems/bin:$PATH"
PS1="\[${C_BOLD}\][\[${C_RED}\]\u\[${C_WHITE}\]@\[${C_GREEN}\]\h \[${C_BLUE}\]\w\[${C_WHITE}\]]\\$ \[${C_RESET}\]"

shopt -s checkwinsize
shopt -s histappend
shopt -s cdspell
shopt -s globstar

# Do not freeze terminal on Ctrl-S
stty -ixon

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}

export LC_ALL="en_US.UTF-8"

export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig"
export GEM_HOME="$HOME/.gems"


[[ -s ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -s ~/.bash_utils ]] && source ~/.bash_utils
[[ -d ~/.bash_completions.d ]] && for f in ~/.bash_completions.d/*; do source "$f"; done


export BASE16_SHELL=$HOME/.config/base16-shell
[[ -s $BASE16_SHELL/profile_helper.sh ]] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [[ "`uname`" == Linux ]]; then
        export QT_STYLE_OVERRIDE=gtk
        export QT_SELECT=qt5

        [[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh
elif [[ "`uname`" == Darwin ]]; then
        export HOMEBREW_GITHUB_API_TOKEN=""
        export NVM_DIR="$HOME/.nvm"

        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
        [[ -f $(brew --prefix)/share/bash-completion/bash_completion ]] && source $(brew --prefix)/share/bash-completion/bash_completion
        [[ -f $(brew --prefix)/etc/profile.d/z.sh ]] && source $(brew --prefix)/etc/profile.d/z.sh
fi
