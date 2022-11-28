#!/bin/bash

set -e
echo "pull-repos.bash: START"
pushd $WS_GALACTIC

vcs import \
  --recursive \
  --input ./src.repos \
  ./src
vcs pull \
  ./src

find ./src/ -name \*.repos -exec vcs import --recursive --input {} ./src \;
popd # $WS_GALACTIC
echo "pull-repos.bash: DONE"