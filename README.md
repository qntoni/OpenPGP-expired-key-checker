# OpenPGP Expired Key Checker

This repository contains a set of shell scripts to help you check the usability of your OpenPGP keys, both public and private. It is useful for identifying expired or otherwise unusable keys, which could save you time when managing a large number of keys. It's 100% open-source.

## Why is this tool needed ?

When working with a large number of OpenPGP keys, such as in the [passbolt-test-data](https://github.com/passbolt/passbolt-test-data) GitHub repository, it can be challenging and time-consuming to manually verify the validity of each key. Some keys might be expired or otherwise unusable, which could lead to issues when using them in encryption or decryption processes.

This is where the OpenPGP Expired Key Checker comes in handy. Instead of going through each key one by one, this tool provides an automated solution to verify the validity of hundreds of keys at once. By utilizing shell scripts, it streamlines the process of checking key usability and identifies any expired or unusable keys. This not only saves you valuable time but also helps ensure the reliability and security of your key management tasks.

## Features
- Check the usability of public and private keys
- Handle large numbers of keys efficiently 
- Automatically delete the imported keys

## Prerequisites
- [GnuPG](https://gnupg.org)
- [GIT](https://git-scm.com/)
- A Unix-based system with a shell (e.g. Bash)

## Get Started

1. Clone this repository 
```bash
git clone https://github.com/qntoni/OpenPGP-expired-key-checker.git
```

2. Navigate to the repository folder
```bash
cd OpenPGP-expired-key-checker
```

3. Make sure the scripts are executable
```bash
chmod +x multiple/gpg_delete_imports.sh multiple/gpg_check_private_keys.sh multiple/gpg_check_public_keys.sh single/gpg_check_with_email.sh
```

4. Update the `KEYS_DIR` variable in both `multiple/gpg_check_public_keys.sh` and `multiple/gpg_check_private_keys.sh` to point to your directory containing the GPG keys.

5. Run the scripts 

You have to check the validity of tons of keys? You will need to search inside `./multiple/`

- To check public keys
```bash
cd multiple/
./gpg_check_public_keys.sh
```

- To check private keys
```bash
cd multiple/
./gpg_check_private_keys.sh
```

- To delete imported keys
```bash
cd multiple/
./gpg_delete_imports.sh
```

You want to see if one of your existing key is not expired, 

- To check if your keys pair is not expired
```bash
cd single/
./gpg_check_with_email.sh
```


## Contributing
All contributions are welcome to improve and expand the functionality of `OpenPGP Expired Key Checker`. Please submit a pull request or create an issue if you have any suggestions, bug reports, or feature requests. All commits must be signed with OpenPGP ⚠️

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Warning
Please be cautious when using these scripts, as they are designed to delete keys from your keyring after checking their usability. If you have your own personal keys or other important keys stored on your system, you might accidentally delete them when running these scripts.

To avoid this, we highly recommend using these scripts within a virtual machine or an isolated environment where your personal or important keys are not at risk.

If you prefer to modify the scripts to prevent the deletion of keys, you can comment out or remove the lines responsible for deleting the keys in both `gpg_check_public_keys.sh` and `gpg_check_private_keys.sh`. For example, comment out or remove the dedicated lines.

In `gpg_check_public_keys.sh`:

```bash
# Delete the imported key to avoid conflicts for next imports
if [ -n "$key_fingerprint" ]; then
    gpg --batch --yes --delete-keys "$key_fingerprint"
fi
```

In `gpg_check_private_keys.sh`:

```bash
# Delete the imported key to avoid conflicts for next imports
if [ -n "$key_fingerprint" ]; then
    gpg --batch --yes --delete-secret-keys "$key_fingerprint"
fi
```
By removing or commenting out these lines, the scripts will no longer delete the imported keys after checking their usability. However, this may result in conflicts when importing subsequent keys with the same key ID. Use this modified version of the script with caution and ensure you understand the implications of keeping the imported keys in your keyring.

## Disclaimer
Please use this tool at your own risk. We are not responsible for any data loss or other issues that may occur while using OpenPGP Expired Key Checker. Always backup your important keys before performing any key management tasks.