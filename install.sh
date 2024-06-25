#!/bin/bash

cd $(dirname $(readlink -f $0))
stow -vv --adopt -t ${HOME} -R $(ls -d */ | tr -d '/')
