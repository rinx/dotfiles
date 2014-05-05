#prompt settings

#prompt

# when connected to remote host
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && local hn="@$HOST"

local p='[%n$hn]%f%(?.%F{green}[%/]%f.%F{red}[%/]%f)'
local pbase="%F{cyan}$p"
local pbase_nor="%F{red}$p"
local lf=$'\n'

PROMPT="%5(~|$pbase$lf|$pbase)%% "

##zsh vi-like keybind mode indicator
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            PROMPT="%5(~|$pbase_nor$lf|$pbase_nor)%% "
        ;;
        main|viins)
            PROMPT="%5(~|$pbase$lf|$pbase)%% "
        ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


#for, while, etc...
PROMPT2="%_%% " 

#missing spell
SPROMPT="%F{yellow}(っ'ヮ'c)< %r is correct? [n,y,a,e]%f: "


#git statuses for Right Prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  #when this script requires long time to run,
  #please, execute follow command.
  #    $touch .git/rprompt-nostatus
  if [[ -e "$gitdir/rprompt-nostatus" ]]; then
      echo "[ ${name}${action}]"
      return
  fi

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%F{red}
  fi
  echo "${color}[ ${name}${action}]%f%b "
}

RPROMPT='`rprompt-git-current-branch`'

