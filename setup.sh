#!/bin/bash
find `pwd` -mindepth 1 -maxdepth 1 ! -name '*.sh' ! -name '.git' -print0  | xargs -0 -I file ln -s -f file ~
