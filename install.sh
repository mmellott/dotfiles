#!/bin/bash
# create symlinks to dotfiles

# git dir this script is stored in
# http://stackoverflow.com/a/246128
src="${BASH_SOURCE[0]}"
while [ -h "$src" ]; do
  dir="$( cd -P "$( dirname "$src" )" && pwd )"
  src="$(readlink "$src")"
  [[ $src != /* ]] && src="$dir/$src"
done
dir="$( cd -P "$( dirname "$src" )" && pwd )"

ln -vsf "$dir/bashrc" ~/.bashrc
ln -vsf "$dir/vimrc" ~/.vimrc

