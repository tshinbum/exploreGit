#!/bin/sh

TARGET=fast_forward

create_add_commit () {
    # $1..filename
    b=$(git branch | grep '^*' | cut -d" " -f2)
    if [ -f $1 ]; then
        action="modified"
    else
        action="created"
    fi
    date >> $1
    git add $1
    git commit -m "$action $1 on branch $b"
}

rm -rf $TARGET
mkdir $TARGET
cd $TARGET
git init
create_add_commit file_on_master

git checkout -b sideline
create_add_commit fileB1
create_add_commit fileB1
create_add_commit fileB2

git checkout master
git merge sideline
