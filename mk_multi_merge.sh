#!/bin/sh

TARGET=multi_merge_testdir

create_add_commit () {
    # $1..filename
    b=$(git branch | grep '^*' | cut -d" " -f2)
    date > $1
    git add $1
    git commit -m "created $1 on branch $b"
}

rm -rf $TARGET
mkdir $TARGET
cd $TARGET
git init
create_add_commit file_on_master

MAX_BRANCHES=20
branch=0
ALL_BRANCHES=""
while [ $branch -lt $MAX_BRANCHES ]; do
    git checkout -b B$branch
    create_add_commit fileB$branch
    ALL_BRANCHES="$ALL_BRANCHES B$branch"
    let branch=$branch+1
done

git checkout master
git branch
echo git merge $ALL_BRANCHES
git merge $ALL_BRANCHES
git branch -d $ALL_BRANCHES
git branch
