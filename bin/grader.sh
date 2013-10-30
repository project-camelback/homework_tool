#!/bin/bash

# grader.sh <$1 github_username> <$2 github_repository> <$3 branch>

mkdir -p tmp
cd tmp

git clone $2 $1
cd $1
git checkout $3

if [ -a Gemfile ] ; then
  bundle install
fi

rspec --format json > .rspec-results.json