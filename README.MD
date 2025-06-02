# secrets

This is a simple script for managing encrypted directories on Linux.

- `secrets save .` takes the contents of a `./secrets/` directory and encrypts
  them into `./secrets.gpg`
- `secrets decrypt .` does the opposite
- the script uses `gpg` and requires encryption and signing key IDs to be
  present in a directory as `.gpgid-encrypt` and `.gpgid-sign`
- the script stores checksum in a file `.secrets-cksum`

See more: `secrets --help`

This script exists primarily for personal use, but it is very general in its
workings. It was created to be combined with other command-line tools, e.g.
[note](https://github.com/randoragon/note).
