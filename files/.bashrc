#
# ~/.bashrc
# 

# If not running interactively, do nothing
[[ $- != *i* ]] && return

[[ -f ~/.bash_colors ]] && . ~/.bash_colors

export PATH="$HOME/.cargo/bin:$HOME/local/bin:$PATH"
PS1="\[${C_BOLD}\][\[${C_RED}\]\u\[${C_WHITE}\]@\[${C_GREEN}\]\h \[${C_BLUE}\]\w\[${C_WHITE}\]]\\$ \[${C_RESET}\]"

shopt -s checkwinsize
shopt -s histappend
shopt -s cdspell
shopt -s globstar

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}

export LC_ALL="en_US.UTF-8"

export EDITOR="nano"
export GIT_EDITOR="$EDITOR"
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig"
export GEM_HOME="$HOME/.gems"

if [[ "`uname`" == Darwin ]]; then

	export PATH="$PATH:/opt/local/bin:/opt/local/sbin"
	export HOMEBREW_GITHUB_API_TOKEN=""
	[[ -f $(brew --prefix)/share/bash-completion/bash_completion ]] && . $(brew --prefix)/share/bash-completion/bash_completion
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_utils ]] && . ~/.bash_utils
