#!/bin/sh

for rev in `git rev-list HEAD`; do
    echo rev:$rev
    #git ls-tree -rt --full-tree $rev; 
    #git show --format="@@SHOW:commit:%H%n@@SHOW:parent:%P" | grep "@@SHOW:" | sed "s/@@SHOW://"
    git for-each-ref --format="commit:%H%nparent:%P" $rev
    echo; 
done
