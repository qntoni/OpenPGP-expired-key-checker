#!/bin/bash

# The path to your folder where you have all your public keys
KEYS_DIR="/PATH/TO/YOUR/GPG/FOLDER"

# Delete all previous public keys 
gpg --batch --yes --delete-keys $(gpg --list-keys --with-colons | awk -F: '/^pub:/ { print $5 }')

# for loop to check all the public keys
for key_file in "$KEYS_DIR"/*public.key; do
    echo "Verifying the key: $key_file"

    # Importe la clé GPG
    import_output=$(gpg --import "$key_file" 2>&1)

    # Vérifie si l'importation a réussi
    if echo "$import_output" | grep -q "Unusable public key"; then
        echo "WARNING: $key_file is unusable."
    else
        echo "OK: $key_file is valide."
    fi

    # Get the fingerprint from the imported key
    key_fingerprint=$(echo "$import_output" | grep -oP "(?<=fpr:::::::::)[0-9A-F]*")

    # Delete the imported key to avoid conflicts for next imports
    if [ -n "$key_fingerprint" ]; then
        gpg --batch --yes --delete-keys "$key_fingerprint"
    fi

    echo ""
done