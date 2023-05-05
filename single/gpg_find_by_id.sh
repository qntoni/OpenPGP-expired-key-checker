#!/bin/bash

# Prompt the user to enter the key ID
echo "Enter the key ID you want to search for:"
read key_id

# Get the key details
key_details=$(gpg --list-keys --with-colons "$key_id" 2>/dev/null)

# Check if the key exists
if [ -z "$key_details" ] || ! echo "$key_details" | grep -q '^pub:'; then
    echo "Key not found. Please make sure you entered the correct key ID."
else
    echo "Key found:"
    echo "$key_details" | grep '^pub:' | cut -d: -f 1-10 | tr ':' ' ' | awk '{ print "Type: " $1, "Size: " $2, "ID: " $5, "Created: " strftime("%Y-%m-%d", $6), "Expires: " ($7 != "" ? strftime("%Y-%m-%d", $7) : "Never") }'
fi