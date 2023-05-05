#!/bin/bash

# Delete all the peristed private keys
for key_fingerprint in $(gpg --list-secret-keys --with-colons | awk -F: '/^sec:/ { print $5 }'); do
    gpg --batch --yes --delete-secret-keys "$key_fingerprint"
done

# Delete all the persisted public keys
for key_fingerprint in $(gpg --list-keys --with-colons | awk -F: '/^pub:/ { print $5 }'); do
    gpg --batch --yes --delete-keys "$key_fingerprint"
done