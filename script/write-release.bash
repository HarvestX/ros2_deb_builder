#!/bin/bash

set -e
echo "write-release.bash START"

if [ -f $REPOS_DIR/dists/stable/Release ]; then
  rm $REPOS_DIR/dists/stable/Release
fi

pushd $REPOS_DIR/dists/stable

do_hash() {
    HASH_NAME=$1
    HASH_CMD=$2
    echo "${HASH_NAME}:" >> $REPOS_DIR/dists/stable/Release
    for f in $(find . -type f \( -name Packages -or -name Packages.gz \)); do
        f=$(echo $f | sed 's/\.\///g' ) # remove ./ prefix
        echo " $(${HASH_CMD} ${f}  | cut -d" " -f1) $(wc -c $f)" >> $REPOS_DIR/dists/stable/Release
    done
}

echo "Origin: My Repository" >> $REPOS_DIR/dists/stable/Release
echo "Label: sample" >> $REPOS_DIR/dists/stable/Release
echo "Suite: stable" >> $REPOS_DIR/dists/stable/Release
echo "Codename: stable" >> $REPOS_DIR/dists/stable/Release
echo "Version: 1.0" >> $REPOS_DIR/dists/stable/Release
echo "Architectures: amd64" >> $REPOS_DIR/dists/stable/Release
echo "Components: main" >> $REPOS_DIR/dists/stable/Release
echo "Description: sample apt repository" >> $REPOS_DIR/dists/stable/Release
echo "Date: $(date -Ru)" >> $REPOS_DIR/dists/stable/Release

do_hash "MD5Sum" "md5sum"
do_hash "SHA1" "sha1sum"
do_hash "SHA256" "sha256sum"

popd # $REPOS_DIR/dists/stable
echo "write-release DONE"