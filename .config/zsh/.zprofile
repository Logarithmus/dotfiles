#!/bin/zsh

# zsh profile file. Runs on login. Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(autosuggest-accept)

# Locale 
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"
# export LC_MONETARY="pl_PL.UTF-8"

export QT_QPA_PLATFORMTHEME=gtk3

# Adds `~/.local/bin` to $PATH
export PATH="$HOME/.local/bin:$HOME/.local/bin/cargo:$HOME/.local/bin/scripts:$PATH"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$PATH:$HOME/android-sdk/tools/bin"
export PATH="${PATH}:${JAVA_HOME}/bin"

# Chromium flags
export ELECTRON_OZONE_PLATFORM_HINT="wayland"

export GH_NO_UPDATE_NOTIFIER=1

# Ignore `rust-toolchain.toml` files in Rust projects and prevent `rustup` from installing
# ~700 MiB toolchain for each such project. Nightly works fine 99.99% of the time
export RUSTUP_TOOLCHAIN="nightly"
export OPENSSL_NO_VENDOR=1
export ZSTD_SYS_USE_PKG_CONFIG=1

# Default programs:
export EDITOR="nvim"
export TERMINAL="kitty.sh"
export TERM="xterm-256color"

# Cut RAM usage for GTK4 programs by half
export GSK_RENDERER="cairo"

# XDG stuff
export XDG_CONFIG_HOME="$HOME/.config"
# Load XDG directories
. "$XDG_CONFIG_HOME/user-dirs.dirs"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors")"

# Use Docker BuildKit
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube" 
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"

export DOTNET_ROOT="$XDG_DATA_HOME/dotnet"
export DOCKER_CONFIG="$XDG_CACHE_HOME/docker"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
alias wget='wget --hsts-file=${XDG_CONFIG_HOME}/wget/wget-hsts'
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_TARGET_DIR="$XDG_CACHE_HOME/cargo/target"
export GOPATH="${XDG_DATA_HOME}/go"
export UNISON="${XDG_DATA_HOME}/unison"
export HISTFILE="${XDG_DATA_HOME}/history"
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mariadb/mysql_history
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup
export CGDB_DIR=$XDG_CONFIG_HOME/cgdb
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
alias s3cmd='s3cmd -c ${XDG_CONFIG_HOME}/s3cmd/config'

# ssh-agent
export SSH_AUTH_SOCK=${HOME}/.ssh/agent
. ${SSH_AUTH_SOCK} > /dev/null


# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='fd --type f'
export LESS="-iR"
export MANROFFOPT='-P -c'
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
export NIX_PATH="/nix/var/nix/profiles/per-user/artur/channels"

# `cargo fix` not only warning, but also errors
export __CARGO_FIX_YOLO=1

# bindgen: point libclang at gcc's include dir (gcc-version-proof) so #include_next <limits.h> resolves
export BINDGEN_EXTRA_CLANG_ARGS="-idirafter $(gcc -print-file-name=include)"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# Lazy-load nvm: sourcing nvm.sh costs ~250 ms. Put the default node on PATH
# without forks, and load nvm.sh only on the first `nvm` call.
if [ -s "$NVM_DIR/alias/default" ]; then
  read -r _nvm_default < "$NVM_DIR/alias/default"
  for _nvm_bin in "$NVM_DIR/versions/node/v${_nvm_default#v}"*/bin; do :; done
  [ -d "$_nvm_bin" ] && export PATH="$_nvm_bin:$PATH"
  unset _nvm_default _nvm_bin
fi
nvm() {
  unset -f nvm
  \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# Load settings for this machine only (work, secrets). Git ignores this file.
[ -f "$ZDOTDIR/.zprofile.local" ] && . "$ZDOTDIR/.zprofile.local"
