#!/bin/sh

set -e

execute () {
    echo "---- [$n]    $@    ----"
    eval $@
    echo
}

n=0

exec 0<$1
while read line; do
    execute $line
    n=$(expr $n + 1)
done
