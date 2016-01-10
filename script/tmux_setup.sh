#!/bin/bash

pwd=`pwd`

rm -rf ~/.tmuxinator/lovestory.yml
ln -s $pwd/script/lovestory.yml ~/.tmuxinator/lovestory.yml
