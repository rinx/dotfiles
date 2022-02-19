# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

OS=$(uname -s)
export GPG_TTY=$TTY
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

HISTFILE=$HOME/.dotfiles.local/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export PATH=$PATH:~/.bin

## https://github.com/mattmc3/zsh_unplugged
## clone a plugin, identify its init file, source it, and add it to your fpath
function plugin-load() {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function plugin-compile() {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}

plugins=(
    romkatv/powerlevel10k
    romkatv/zsh-defer

    zshzoo/history
    zshzoo/zstyle-completions
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    hlissner/zsh-autopair
    mollifier/cd-gitroot
    peterhurford/up.zsh

    zshzoo/compinit
    zdharma-continuum/fast-syntax-highlighting
)

plugin-load $plugins

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt always_to_end
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt complete_in_word
setopt no_menu_complete

setopt extended_glob
setopt glob_dots

setopt no_clobber
setopt no_correct
setopt no_correct_all
setopt no_flow_control
setopt interactive_comments
setopt no_mail_warning
setopt path_dirs
setopt rc_quotes
setopt no_rm_star_silent

setopt auto_resume
setopt no_bg_nice
setopt no_check_jobs
setopt no_hup
setopt long_list_jobs
setopt notify

setopt prompt_subst

setopt no_beep
setopt combining_chars
setopt vi

autoload colors
colors

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

bindkey '^R' history-incremental-search-backward
bindkey '^E' history-incremental-search-forward

edit_current_line() {
    local tmpfile=$(mktemp)
    echo "$BUFFER" > $tmpfile
    nvim $tmpfile -c "normal $" -c "set filetype=zsh"
    BUFFER="$(cat $tmpfile)"
    CURSOR=${#BUFFER}
    rm $tmpfile
    zle reset-prompt
}
zle -N edit_current_line
bindkey '^O' edit_current_line

function precmd() {
    if [ ! -z $TMUX ]; then
        tmux refresh-client -S
    fi
}

if [ -n "${NVIM_LISTEN_ADDRESS}" ]; then
    export EDITOR='nvr'
    export GIT_EDITOR="$EDITOR -cc vsplit --remote-wait"
else
    export EDITOR='nvim'
    export GIT_EDITOR="$EDITOR"
fi

export VISUAL="$EDITOR"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -n "${DOCKERIZED_DEVENV}" ]; then
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❯"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❮"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❮"
fi

zsh-defer source $HOME/.dotfiles/zshrc.d/aliases.zsh
zsh-defer source $HOME/.dotfiles/zshrc.d/docker.zsh

if [ ! -f "$HOME/.zshrc.zwc" -o "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]; then
    zcompile $HOME/.zshrc
fi

if [ ! -f "$HOME/.zcompdump.zwc" -o "$HOME/.zcompdump" -nt "$HOME/.zcompdump.zwc" ]; then
    zcompile $HOME/.zcompdump
fi
