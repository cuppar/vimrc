#!/bin/env bash

# copy rc to git repo
cp ~/.vimrc ~/project/vimrc

# push to github
cd ~/project/vimrc
git add .vimrc
git commit -m 'update .vimrc'
git push

