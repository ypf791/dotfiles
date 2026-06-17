precmd()
{
	psvar=( OOVBMac "$(printf "%2x" "$?")" "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" )
}

PS1='
%F{cyan}[%n@%1v %D{%H:%M}]%F{9}%0(?.%F{11}.)[%2v]%F{12}[%~]%3(V.%F{8}[%3v].)%f
$ '
