#!/bin/bash
# configure git

set -x

git config --global user.name 'Matthew Mellott'
git config --global user.email mmellott@users.noreply.github.com

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h %Creset%s %Cblue[%cn]"'
git config --global alias.st 'status -s -b'

git config --global diff.tool gvimdiff
git config --global alias.dt 'difftool -y'

git config --global merge.tool gvimdiff
git config --global merge.conflictstyle diff3
