#!/bin/bash

set -e
echo "update-rosdep.bash: START"
pushd $WS_GALACTIC

if [ -f ./my_rosdep.yaml ]; then
  rm ./my_rosdep.yaml
fi

PKG_NAME_LIST=$(colcon list -tn)
for NAME in $PKG_NAME_LIST; do
  echo "$NAME:" >> ./my_rosdep.yaml
  DEB_NAME=$(echo $NAME | sed -e 's/_/-/g' | sed -e 's/^/ros-galactic-/g')
  echo "  ubuntu: [$DEB_NAME]" >> ./my_rosdep.yaml
done

echo "yaml file://$(pwd)/my_rosdep.yaml" | sudo tee /etc/ros/rosdep/sources.list.d/50-my-packages.list
rosdep update
sudo apt-get update
rosdep install -y -i --from-path ./src

popd # $WS_GALACTIC
echo "update-rosdep.bash: DONE"