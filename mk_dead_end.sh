#!/bin/sh

DEAD=dead_end

rm -rf $DEAD
mkdir $DEAD
cd $DEAD
git init
echo "first commit" > A
git add A
git commit -m "first commit"
git tag first_commit
echo "second commit" >> A
git add A
git commit -m "second commit"
git checkout first_commit
echo "commit in dead end" >> A
git add A
git commit -m "changed A in dead end"
git checkout -b $DEAD
dead_commit=`git log -1 --format="%H"`
git checkout master
git branch -D $DEAD
git show $dead_commit
git fsck --unreachable --full --verbose
git fsck --unreachable HEAD \
                   $(git for-each-ref --format="%(objectname)" refs/heads)
git fsck --lost-found
git prune -v $dead_commit
git prune $(git rev-parse --all)
git repack
git prune-packed
git gc --prune=now
git gc --aggressive
git show $dead_commit

