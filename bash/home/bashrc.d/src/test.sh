#!/bin/bash

. ~/dotfiles/bash/home/bashrc.d/src/bookmark

enum_bookmark

exit 0

test_fx() {
	echo ===${NAME}=== >&2
	echo "value:     [${!NAME}]" >&2
	echo "prefix:     ${PREFIX}" >&2
	echo "condition:  ${CONDITION}" >&2

	echo "declare ${NAME}=\"${!NAME}\"; export \"${NAME}\""
}

eval "$(_oo_bm_foreach_tag_obj "test_fx")"

echo ===[test]===
echo ${branch}
echo ${platform}
echo ${project}
echo ${package}
