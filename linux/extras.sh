#!/bin/bash

# mkdir -p $HOME/PROJECTS/github.com

function dclone {
	directory=$(python -c "print('$1'.split('/')[-2])")
	echo "Directory: $directory"
	git clone $1 "$directory"
}
