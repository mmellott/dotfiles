#!/bin/bash
# setup dotfile configuration

# get dir this script is stored in
# http://stackoverflow.com/a/246128
src="${BASH_SOURCE[0]}"
while [ -h "$src" ]; do
  dir="$( cd -P "$( dirname "$src" )" && pwd )"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
dir="$( cd -P "$( dirname "$src" )" && pwd )"

# create symlinks
ln -vsf "$dir/bashrc" ~/.bashrc
ln -vsf "$dir/vimrc" ~/.vimrc
ln -vsf "$dir/screenrc" ~/.screenrc

# run git config script
"$dir/git-config.sh"

