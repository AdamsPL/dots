#!/bin/bash

cd $(dirname $(readlink -f $0))
stow -vv --no-folding $* -t ${HOME} -R */
