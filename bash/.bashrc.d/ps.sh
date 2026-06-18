#!/bin/bash

case "$TERM" in
    xterm-color|*-256color)
        color_prompt=yes
        ;;
esac

# override PS1 before its being typed
__oo_prompt_cmd() {
    local RET=$?

    local PS1_CHROOT='${debian_chroot:+($debian_chroot)}'
    local PS1_USERHOST='[\u@\h \A]'
    local PS1_RET='[$(printf "%2x" '"$RET"')]'
    local PS1_PATH='[\w]'
    local PS1_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"

    local C_USERHOST='\[\e[0;36m\]'
    local C_RET='\[\e[93m\]'
    local C_PATH='\[\e[1;34m\]'
    local C_BRANCH='\[\e[1;30m\]'
    local C_DEFAULT='\[\e[0m\]'

    [ $RET -eq 0 ] || C_RET='\[\e[91m\]'
    [ "$EUID" -eq 0 ] && C_USERHOST='\[\e[1;31m\]'   # root: red user@host

    PS1="\n${PS1_CHROOT}${C_USERHOST}${PS1_USERHOST}${C_RET}${PS1_RET}${C_PATH}${PS1_PATH}${C_BRANCH}${PS1_BRANCH:+[${PS1_BRANCH}]}${C_DEFAULT}\n\$ "
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=__oo_prompt_cmd
fi
unset color_prompt
