#!/bin/bash

set -e

on_error() {
  echo "Error has been trapped!"
  if [ -f $SCRIPT_DIR/on-build-failed.bash ]; then
    source $SCRIPT_DIR/on-build-failed.bash
  fi
}

trap "on_error" ERR

echo "run-all.bash: START"

source /opt/ros/galactic/setup.bash
#source $SCRIPT_DIR/clean-deb.bash
source $SCRIPT_DIR/pull-repos.bash
source $SCRIPT_DIR/update-rosdep.bash
source $SCRIPT_DIR/generate-deb.bash
source $SCRIPT_DIR/pool-deb.bash
source $SCRIPT_DIR/write-packages.bash
source $SCRIPT_DIR/write-release.bash
source $SCRIPT_DIR/sign-with-gpg.bash

echo "run-all.bash: DONE"