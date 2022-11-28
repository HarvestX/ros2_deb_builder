#!/bin/bash

set -e
echo "generate-deb.bash: START"
pushd $WS_GALACTIC

# change IFS to iterate over lines instead of words
IFS_ORIGINAL=$IFS
IFS=$'\n'

PKG_LIST=$(colcon list -t)
for ITEM in $PKG_LIST; do
  PKG_NAME=$(echo $ITEM | awk '{ print $1 }')
  PKG_PATH=$(echo $ITEM | awk '{ print $2 }')
  DEB_NAME=$(echo $PKG_NAME | sed -e 's/_/-/g' | sed -e 's/\(.*\)/\L\1/' | sed -e 's/^/ros-galactic-/g')
  
  pushd $PKG_PATH
  bloom-generate rosdebian
  fakeroot debian/rules binary
  sudo apt install -y ../$DEB_NAME*.deb
  popd
done

IFS=$IFS_ORIGINAL

# check result
NUM_OF_PKG=$(colcon list -t | wc -l)
NUM_OF_DEB=$(find $WS_GALACTIC/src/ -name \*.deb | wc -l)
echo "generate-deb.bash: generated $NUM_OF_DEB / $NUM_OF_PKG packages."
if [ $NUM_OF_PKG != $NUM_OF_DEB ]; then
  echo "generate-deb.bash: [ERROR] failed to build some of the targets."
  exit 1
fi

popd # $WS_GALACTIC
echo "generate-deb.bash: DONE"