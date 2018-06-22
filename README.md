# Project - THOR
An attempt to make developer and devops life easier.

## Dependencies
* docker
* cURL
* Makefile
* [shc](https://github.com/neurobin/shc)

## Installation
```bash
make install
```

## Persistent Export
Add `$HOME/.thor_profile` to your rc file:
```bash
echo "test -f \$HOME/.thor_profile && . \$HOME/.thor_profile" >> $HOME/[your_rc_file]
```

## Temporary Export in Current Shell Terminal
Execute:
```bash
test -f $HOME/.thor_profile && . $HOME/.thor_profile
```

## Maintainer
- Sanadhi Sutandi ([@sanadhis](https://github.com/sanadhis))

## LICENSE
MIT.