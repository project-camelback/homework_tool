#!/bin/bash

# grader.sh <$1 github_username> <$2 github_repository> <$3 branch>
unset BUNDLE_GEMFILE

mkdir -p tmp
cd tmp

git clone $2 $1
cd $1
git checkout $3

# Comment out 'binding.pry' in all ruby files
# find ./ -name \*.rb -exec sed -i "s/binding.pry/#binding.pry/g" {} \;

if [ -a Gemfile ] ; then
  bundle install --verbose
fi

bundle exec rspec --format json --out .rspec-results.json --require ../../rspec_setup.rb &> .rspec-results.errors