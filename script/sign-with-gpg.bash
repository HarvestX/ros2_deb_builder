#!/bin/bash

set -e
echo "sign-with-gpg.bash: START"

cat $SCRIPT_DIR/key/*.gpg.private | gpg --import
cat $REPOS_DIR/dists/stable/Release | gpg --default-key example -abs --clearsign > $REPOS_DIR/dists/stable/InRelease

echo "sign-with-gpg.bash: DONE"