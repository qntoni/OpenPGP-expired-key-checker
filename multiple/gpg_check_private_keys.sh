#!/bin/bash

# The path to your folder where you have all your private keys
KEYS_DIR="/PATH/TO/YOUR/GPG/FOLDER"

# Delete all previous private keys
gpg --batch --yes --delete-secret-keys $(gpg --list-secret-keys --with-colons | awk -F: '/^sec:/ { print $5 }')

# For loop to check all the private keys
for key_file in "$KEYS_DIR"/*private.key; do
    echo "Verifying the key: $key_file"

    # Import the GPG key
    import_output=$(gpg --import "$key_file" 2>&1)

    # Check if the import was successful
    if echo "$import_output" | grep -q "Unusable secret key"; then
        echo "WARNING: $key_file is unusable."
    else
        echo "OK: $key_file is valid."
    fi

    # Get the fingerprint from the imported key
    key_fingerprint=$(echo "$import_output" | grep -oP "(?<=fpr:::::::::)[0-9A-F]*")

    # Delete the imported key to avoid conflicts for next imports
    if [ -n "$key_fingerprint" ]; then
        gpg --batch --yes --delete-secret-keys "$key_fingerprint"
    fi

    echo ""
done
