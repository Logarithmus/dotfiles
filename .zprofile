#!/bin/zsh

# zsh profile file. Runs on login. Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# Locale 
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

# Qt theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Adds `~/.local/bin` to $PATH
export PATH="$HOME/.local/bin:$HOME/.local/bin/scripts:$PATH"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$PATH:$HOME/android-sdk/tools/bin:/opt/texlive/2020/bin/x86_64-linuxmusl/:$GOPATH/bin"
# Chromium flags
export CHROME_FLAGS="--password-store=detect --enable-oop-rasterization \
--enable-features=UseOzonePlatform --ozone-platform=wayland --in-process-gpu \
--use-gl=egl --disable-gpu-memory-buffer-video-frames"
# Default programs:
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="chromium"
export READER="zathura"

# XDG stuff
export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
. $XDG_CONFIG_HOME/user-dirs.dirs


# $HOME clean-up:
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
alias wget='wget --hsts-file=${XDG_CONFIG_HOME}/wget/wget-hsts'
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_TARGET_DIR="${XDG_CACHE_HOME}/cargo/target"
export PATH="${PATH}:${CARGO_HOME}/bin"
export GOPATH="${XDG_DATA_HOME}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME}/unison"
export HISTFILE="${XDG_DATA_HOME}/history"
export UPM_NPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/npm"
export UPM_CACHE_PATH="${XDG_CACHE_HOME}/unity/packages"
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mariadb/mysql_history
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup
export CGDB_DIR=$XDG_CONFIG_HOME/cgdb
alias s3cmd='s3cmd -c ${XDG_CONFIG_HOME}/s3cmd/config'

# Force OpenCL 1.2 instead of 1.1
export CLOVER_PLATFORM_VERSION_OVERRIDE=1.2
export CLOVER_DEVICE_VERSION_OVERRIDE=1.2
export CLOVER_DEVICE_CLC_VERSION_OVERRIDE=1.2

# iostat color
export S_COLORS=always

# ssh-agent
export SSH_AUTH_SOCK=${HOME}/.ssh/agent
. ${SSH_AUTH_SOCK} > /dev/null


# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export _JAVA_OPTIONS="${_JAVA_OPTIONS} -Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -XX:+UseG1GC -XX:+UseStringDeduplication"
export NIX_PATH="/nix/var/nix/profiles/per-user/artur/channels"

export TEXMFLOCAL="/opt/texlive/texmf-local"

# Libreoffice fix
export SAL_USE_VCLPLUGIN=kf5

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

[ ! -f ${XDG_CONFIG_HOME}/shortcutrc ] && shortcuts >/dev/null 2>&1 &

# Switch escape and caps if tty and no passwd required:
#sudo -n loadkeys ${XDG_DATA_HOME}/larbs/ttymaps.kmap 2>/dev/null
