#!/bin/sh

rm -rf MASTER VERIFICATION FEATURE
set -x
set -e

mkdir MASTER
cd MASTER
git init
touch A_file
git add A_file
git commit -m "initial commit, added A_file"
cd ..

git clone MASTER FEATURE
cd FEATURE
git branch featureB
git checkout featureB
echo "New feature" > b_file
git add b_file
git commit -m "implemented featue B"
cd ..

git clone MASTER VERIFICATION
cd VERIFICATION
git fetch ../FEATURE featureB:theirFeatureB
git checkout theirFeatureB
cat b_file
echo "#verified" >> b_file
cat b_file
git add b_file
git commit -m verified
git push origin theirFeatureB:verifiedFeatureB
cd ..

cd MASTER
git merge verifiedFeatureB
git branch -d verifiedFeatureB
git branch -l
