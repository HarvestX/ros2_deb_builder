#!/bin/bash

set -e

gpg --no-tty --batch --gen-key ./gpg.batch
gpg --armor --export sample > ./sample.gpg
gpg --armor --export-secret-keys sample > ./sample.gpg.private

# Store private key for importing in docker container
mv ./sample.gpg.private ../script/key/

# Store public key in gpg directory for distribution
mv ./sample.gpg ../repos/gpg/
