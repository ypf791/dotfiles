precmd()
{
	psvar=( OOVBMac "$(printf "%2x" "$?")" )
}

PS1='
%F{cyan}[%n@%1v %D{%H:%M}]%F{9}%0(?.%F{11}.)[%2v]%F{8}[%~]%f
$ '
