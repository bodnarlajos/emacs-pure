#!/bin/sh

# git-delta binary
wget https://github.com/dandavison/delta/releases/download/latest/git-delta_0.16.5_amd64.deb -O /tmp/git-delta.deb && sudo apt install -y /tmp/git-delta.deb && rm /tmp/git-delta.deb

