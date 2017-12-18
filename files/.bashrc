#
# ~/.bashrc
#

# If not running interactively, do nothing
[[ $- != *i* ]] && return

[[ -f ~/.bash_colors ]] && . ~/.bash_colors

export PATH="$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/local/bin:$HOME/.gems/bin:$PATH"
PS1="\[${C_BOLD}\][\[${C_RED}\]\u\[${C_WHITE}\]@\[${C_GREEN}\]\h \[${C_BLUE}\]\w\[${C_WHITE}\]]\\$ \[${C_RESET}\]"

shopt -s checkwinsize
shopt -s histappend
shopt -s cdspell
shopt -s globstar

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}

export LC_ALL="en_US.UTF-8"

export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig"
export GEM_HOME="$HOME/.gems"

if [[ "`uname`" == Darwin ]]; then
	export HOMEBREW_GITHUB_API_TOKEN=""
	[[ -f $(brew --prefix)/share/bash-completion/bash_completion ]] && . $(brew --prefix)/share/bash-completion/bash_completion
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_utils ]] && . ~/.bash_utils
[[ -d ~/.bash_completions.d ]] && for f in ~/.bash_completions.d/*; do . "$f"; done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export BASE16_SHELL=$HOME/.config/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
