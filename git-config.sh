#!/bin/bash
# configure git

echo "Don't forget to manually set user.name and user.email!"

set -x

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h %Creset%s %Cblue[%cn]"'

git config --global diff.tool gvimdiff
git config --global alias.dt 'difftool -y'

git config --global merge.tool gvimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
