#!/bin/bash
# Setup pathogen and clone plugins

set -ex

mkdir -p ~/.vim/autoload
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone --recursive https://github.com/mmellott/vim-plugins ~/.vim/bundle
