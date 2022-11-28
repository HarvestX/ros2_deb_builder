#!/bin/bash

set -e
echo "write-packages.bash START"

pushd $REPOS_DIR

dpkg-scanpackages --arch amd64 pool/ > dists/stable/main/binary-amd64/Packages
cat dists/stable/main/binary-amd64/Packages | gzip -9 > dists/stable/main/binary-amd64/Packages.gz

popd # $REPOS_DIR
echo "write-packages.bash DONE"