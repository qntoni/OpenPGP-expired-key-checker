#!/bin/bash

# List all GPG keys
echo "Listing all GPG keys:"
gpg --list-keys

# Prompt the user to enter the email address or key ID
echo -e "\nEnter the email address or key ID associated with the GPG key you want to check:"
read user_input

# Get the key details
key_details=$(gpg --list-keys --with-colons "$user_input" 2>/dev/null)

# Check if the key exists
if [ -z "$key_details" ] || ! echo "$key_details" | grep -q '^pub:'; then
    echo "Key not found. Please make sure you entered the correct email address or key ID."
    exit 1
fi

# Get the key fingerprint
key_fingerprint=$(echo "$key_details" | awk -F: '/^pub:/ { print $5 }')

# Get the key expiration date
key_expiration_date=$(echo "$key_details" | awk -F: '/^pub:/ { print $7 }')

# Check if the key is expired
if [ -z "$key_expiration_date" ]; then
    echo "The key with email or ID '$user_input' is valid and does not have an expiration date."
elif [ "$(date +%s)" -gt "$key_expiration_date" ]; then
    echo "The key with email or ID '$user_input' is expired."
else
    echo "The key with email or ID '$user_input' is valid and not expired."
fi
