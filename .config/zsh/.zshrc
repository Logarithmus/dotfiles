# Logarithmus' config for the Zoomer Shell

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
# gpg-agent
export GPG_TTY=$TTY

# https://users.rust-lang.org/t/solved-how-to-step-into-std-source-code-when-debugging-in-vs-code/25319
export RUST_GDB="cgdb -ex 'set substitute-path \
/rustc/a178d0322ce20e33eac124758e837cbd80a6f633 \
$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust'"

alias cmake='cmake -GNinja -DCMAKE_LINKER=mold'
alias tokei='tokei -s code'
alias less='less -RWi'
alias exa='exa --color=always --group-directories-first --icons'
alias ls='exa --color=always --group-directories-first --icons'
alias ll='exa -la --time-style=long-iso --color=always --group-directories-first --icons'
alias tree='exa -T --time-style=long-iso --color=always --group-directories-first --icons'
alias diff='diff -u --color=always'
alias ip='ip -color=always'
alias rg='rg -p'
alias fd='fd --color always'
alias watch='watch -c'
alias dd='dd status=progress'
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'

# idiot-proof protection
alias mv='mv -iv'
alias ln='ln -iv'

glow() {
	if [ -z "$1" ]; then
		`/bin/which --skip-functions glow` README.md
	else
		`/bin/which --skip-functions glow` $@
	fi
}

# conveniently open files
open() {
	xdg-open "$1" &|
}

# create & cd to a directory in a single command
mcdir() {
	mkdir $@ && cd "$1"
}


# auto add -r option to rm when trying to remove directory
# & idiot proof protection
rm() {
	if [ ! -L ${@: -1} ] && [ -d ${@: -1} ]; then
		/bin/rm -riv "$@"
	else
		/bin/rm -iv "$@"
	fi
}

# auto add -r option to cp when trying to cp directory
# & idiot proof protection
cp() {
	if [ ! -L ${@: -1} ] && [ -d ${@: -1} ]; then
		/bin/cp -riv --reflink=auto "$@"
	else
		/bin/cp -iv --reflink=auto "$@"
	fi
}

# auto parallel make
make() {
	/bin/make "$@" -j`nproc`
}

# Enable switching between images in same directory
imv() {
	if [ -n "$2" ]; then
		/bin/imv $@ &|
	elif [ -f "$1" ]; then
		/bin/imv "`dirname "$1"`" -n "`basename "$1"`" &|
	elif [ -d "$1" ]; then
		/bin/imv "$1" &|
	elif [ -z "$1" ]; then
		/bin/imv . &|
	fi
}

# Use curl user agent by default to make sites like wttr.in work correctly
xh() {
	`/bin/which --skip-functions xh` -b "$@" "User-Agent:curl/7.77.0"
}

# xbps fuzzy finder
xs() {
	xpkg -a | sk -m --preview 'xq {1}' --preview-window=right:66%:wrap | xargs -ro xi
}

# fish-like autosuggestions
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# bindkey '	' autosuggest-accept

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -l\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

autoload -U zmv

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# powerlevel10k zsh theme
. $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
# Load syntax highlighting; should be last.
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fish-like history search
# . /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# ssh-agent
ssh-add ~/.ssh/id_ed25519 &> /dev/null

# Commands to be executed before the prompt is displayed
# Save current working dir

# Change to saved working dir
[[ -f "${ZDOTDIR}/cwd" ]] && cd "$(< ${ZDOTDIR}/cwd)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

precmd () {
	pwd > "${ZDOTDIR}/cwd"
	print -Pn "\e]2;%n@%M | %~\a"
}

tabs -4
