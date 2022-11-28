#!/bin/bash

set -e
echo "clean-deb.bash: START"
pushd $WS_GALACTIC

# change IFS to iterate over lines instead of words
IFS_ORIGINAL=$IFS
IFS=$'\n'

PKG_PATH=$(colcon list -t)
for ITEM in $PKG_PATH; do
  PKG_NAME=$(echo $ITEM | awk '{ print $1 }')
  PKG_PATH=$(echo $ITEM | awk '{ print $2 }')
  DEB_NAME=$(echo $PKG_NAME | sed -e 's/_/-/g' | sed -e 's/\(.*\)/\L\1/' | sed -e 's/^/ros-galactic-/g')

  pushd $PKG_PATH
  if [ -d debian/ ]; then
    rm -rf ./debian/
  fi

  if [ -f ../$DEB_NAME*.deb ]; then
    rm ../$DEB_NAME*.deb
  fi
  if [ -f ../$DEB_NAME*.ddeb ]; then
    rm ../$DEB_NAME*.ddeb
  fi
  # if dpkg -s $DEB_NAME; then
  #   sudo apt remove -y $DEB_NAME
  # fi
  popd
done

IFS=$IFS_ORIGINAL

popd # $WS_GALACTIC
echo "clean-deb.bash: DONE"