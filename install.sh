#!/bin/bash

cd $(dirname $(readlink -f $0))
stow -v -t ${HOME} $* $(ls -d */ | tr -d '/')
