# Change to saved working dir, but only if the launcher did not set one (e.g.
# Thunar "Open Terminal Here"). Must run before instant prompt: p10k keys the
# cached prompt by the starting directory.
[ "$PWD" = "$HOME" ] && [ -f "${ZDOTDIR}/cwd" ] && cd "$(< ${ZDOTDIR}/cwd)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Login shells already sourced .zprofile; source it only for non-login shells.
[[ -o login ]] || . ~/.zprofile
eval "$(antidot init)"
export TERM="xterm-256color"
# gpg-agent
export GPG_TTY=$TTY

# https://users.rust-lang.org/t/solved-how-to-step-into-std-source-code-when-debugging-in-vs-code/25319
# export RUST_GDB="cgdb -ex 'set substitute-path \
# /rustc/a178d0322ce20e33eac124758e837cbd80a6f633 \
# $RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust'"

alias qr='qrencode -t ansiutf8'

# cargo
alias ck='cargo check'
alias rn='cargo run'
alias cfk='cargo first check'
alias ct='cargo test --lib'
alias fmt='cargo fmt'

# Swallowing (disabled due to bugs)
# alias hide='swayhide'
# alias zathura='hide zathura'
# alias firefox='hide firefox'
# alias brave='hide brave'
# alias mpv='hide mpv'

alias fd='fdfind'
alias ws='websocat'
alias jq='jq --indent 2'
alias vi='nvim'
alias neo='swayhide neovide'
alias rsync='rsync --info=progress2'
alias cmake='cmake -GNinja -DCMAKE_LINKER=mold'
alias tokei='tokei -s code -e vendor'
alias ls='eza --color=auto --group-directories-first --icons=auto'
alias ll='eza -la --time-style=long-iso --color=auto --group-directories-first --icons=auto'
alias tree='eza -T --time-style=long-iso --color=auto --group-directories-first --icons=auto'
alias cat='batcat'
#alias ip='ip -color=always'
#alias fd='fd --color always'
alias watch='watch -c'
alias dd='dd status=progress'
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias fetch='fastfetch'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'

# Git aliases
# Most used git command should be short.
alias ga='git add -u'
alias gap='ga -p'
gc() {
  git diff --cached | grep '\btap[ph]\b' >/dev/null &&
    echo "\e[0;31;29mOops, there's a #tapp or similar in that diff.\e[0m" ||
    ga && git commit -v "$@"
}

gp() {
  if [ -n "$1" ]; then
    ga && gc -m "$1" && git push
  else
    git push
  fi
}

alias nvimdiff='nvim -d'
alias gull='git pull'
alias gs='git status -sb'
alias gbr='git branch -v'
alias gch='git cherry-pick'
alias gcm='git commit -v --amend'
alias gco='git checkout'
alias gd='git diff -M'
alias gd.='git diff -M --color-words="."'
alias gdc='git diff --cached -M'
alias gdc.='git diff --cached -M --color-words="."'
alias gf='git add -u && git commit -m fix && git push'
alias fix=gf
alias glog='git log --date-order --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ad%Creset" --date=format:"%d.%m.%Y %H:%M"'
alias gl='glog --graph'
alias gla='gl --all'
alias gm='git merge --no-edit'
alias gmc='git commit --no-edit'
alias gup='git pushup'
alias grb='git rebase -p'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias gr='git reset'
alias grh='git reset --hard'
alias grsh='git reset --soft HEAD~'
alias grv='git remote -v'
alias gshow='git show'
alias gshow.='git show --color-words="."'

# idiot-proof protection
alias mv='mv -iv'
alias ln='ln -iv'

# Use full process name to match
alias pkill='pkill -f'

reload_gtk_theme() {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}

glow() {
  if [ -z "$1" ]; then
    `/bin/which --skip-functions glow` README.md
  else
    `/bin/which --skip-functions glow` $@
  fi
}

# conveniently open files
open() {
  file="$1"
  [ -f "$file" ] || { echo "File not found: $file"; exit 1; }
  
  # Get MIME type
  mime_type=$(xdg-mime query filetype "$file")
  
  # Get default .desktop file
  desktop_file=$(xdg-mime query default "$mime_type")
  [ -n "$desktop_file" ] || { echo "No default app for $mime_type"; exit 1; }
  
  # Find Exec line from desktop file
  desktop_path=$(find /usr/share/applications ~/.local/share/applications -name "$desktop_file" 2>/dev/null | head -n 1)
  [ -f "$desktop_path" ] || { echo "Desktop file not found: $desktop_file"; exit 1; }
  
  # Extract the Exec line, remove arguments
  exec_line=$(grep -E '^Exec=' "$desktop_path" | head -n 1 | sed -E 's/^Exec=([^ ]+).*/\1/')
  [ -n "$exec_line" ] || { echo "Could not parse Exec line"; exit 1; }
  
  # Launch the program
  "$exec_line" $@
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

# Use curl user agent by default to make sites like wttr.in work correctly
xh() {
  $CARGO_HOME/bin/xh -b --format-options 'json.indent:2' "$@" "User-Agent:curl/82.1"
}

# Make `clang-format` work more like `cargo fmt`
cppfmt() {
  /bin/fd '.*(\.h|\.c)(pp|xx)?$' | parallel clang-format --fallback-style=none -i
}

# Auto-change directory after `git clone`
git() {
    case "$1" in
        show|log) /bin/git "$@" --ext-diff ;;
        clone)
            /bin/git "$@"
            repo_name="`basename "$_" .git`"
            cd "$repo_name" && echo "cd $repo_name"
            ;;
        *) /bin/git "$@" ;;
    esac
}

# Auto-change directory after `gh repo clone`
gh() {
    if [ "$1" = "repo" ] && [ "$2" = "clone" ] || [ "$2" = "fork" ]; then
        /usr/bin/gh "$@"
        repo_name="`basename "$_" .git`"
        cd "$repo_name" && echo "cd $repo_name"
    else
        /usr/bin/gh "$@"
    fi
}

#. /usr/share/fzf/shell/key-bindings.zsh
#. /usr/share/fzf/shell/completion.zsh
export FZF_COMPLETION_TRIGGER='**'

# Bind widgets once at startup, not before every prompt (~11 ms per prompt).
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
# bindkey ' ' autosuggest-accept

# Enable colors and change prompt:
autoload -U colors && colors  # Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd    # Automatically cd into typed directory.
stty stop undef <$TTY >$TTY # Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
setopt EXTENDED_GLOB
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
[ -f "${ZDOTDIR}/shortcutrc" ] && . "${ZDOTDIR}/shortcutrc"
[ -f "${ZDOTDIR}/aliasrc" ] && . "${ZDOTDIR}/aliasrc"
[ -f "${ZDOTDIR}/zshnameddirrc" ] && . "${ZDOTDIR}/zshnameddirrc"

# Basic auto/tab complete:
export FPATH="$FPATH:$ZDOTDIR/completions"
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zmodload zsh/complist
# Rebuild completion dump only if older than 24h; else skip audit+rescan (-C).
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n $_zcompdump(#qN.mh+24) ]]; then
  compinit -i -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump
_comp_options+=(globdots)    # Include hidden files.


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Copy/paste to/from system clipboard
function vi-yank-sys {
    zle vi-yank
    echo "$CUTBUFFER" | wl-copy
}
function vi-paste-sys() {
  LBUFFER+=$(wl-paste --no-newline 2>/dev/null)
}
zle -N vi-paste-sys
zle -N vi-yank-sys
bindkey -M vicmd 'p' vi-paste-sys
bindkey -M vicmd 'y' vi-yank-sys

autoload -Uz bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

autoload bashcompinit && bashcompinit
complete -C "$HOME/.local/bin/aws_completer" aws

# TODO: investigate why it doesn't work
export ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT="true"
export ZSH_SYSTEM_CLIPBOARD_USE_WL_CLIPBOARD="true"
[ -f "${ZDOTDIR}/zsh-system-clipboard.zsh" ] && . "${ZDOTDIR}/zsh-system-clipboard.zsh"

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
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

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
# fish-like history search
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. $XDG_DATA_HOME/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# ssh-agent
ssh-add ~/.ssh/id_ed25519 &> /dev/null

# Commands to be executed before the prompt is displayed
# Save current working dir

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[ -f "${ZDOTDIR}/.p10k.zsh" ] && . ~/.config/zsh/.p10k.zsh

precmd () {
  pwd > "${ZDOTDIR}/cwd"
  print -Pn "\e]2;%n@%M | %~\a"

}

tabs -4
eval "$(zoxide init zsh)"

# Decode a percent-encoded URL string. Use urldecode -p to also change "+" to a space.
urldecode() {
  local fn=unquote
  [[ $1 == -p ]] && { fn=unquote_plus; shift; }
  python3 -c "import sys, urllib.parse as u; print(u.$fn(sys.argv[1]))" "$*"
}

# Load settings for this machine only (work, secrets). Git ignores this file.
[ -f "$ZDOTDIR/.zshrc.local" ] && . "$ZDOTDIR/.zshrc.local"
