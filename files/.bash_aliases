#
# ~/.bash_aliases
#


alias grep='grep --color=auto'
alias sudo='sudo '

alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias yt-dl="youtube-dl -o '%(title)s.%(ext)s' -i -x --audio-quality 320K --audio-format mp3"

alias rusti='rustup run nightly-2016-08-01 rusti'
alias rustfmt='rustup run nightly cargo fmt --all'


case "`uname`" in
Darwin )
	alias ls='ls -G'
	
	alias md5sum='md5'
	alias sha1sum='shasum -a 1'
	alias sha224sum='shasum -a 224'
	alias sha256sum='shasum -a 256'
	alias sha384sum='shasum -a 384'
	alias sha512sum='shasum -a 512'

	alias strace='sudo dtruss'
	alias ldd='otool -L'
	alias lsblk='diskutil list'
	alias objdump='otool -tVC'

	alias shot='screencapture -x -T 5 ~/Dropbox/screenshots/`date +%y-%m-%d_%H:%M:%S`.png'
	;;

Linux )
	alias ls='ls -G --color=auto'

	alias open='xdg-open'
	alias shot='scrot -c -d 5 ~/Dropbox/screenshots/`date +%y-%m-%d_%H:%M:%S`.png'

	;;

esac
