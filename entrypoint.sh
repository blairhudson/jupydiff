#!/bin/bash
for f in *.ipynb; 
do nbdime diff --no-color -s $f >> output.txt;
cat output.txt;
done

PATH=$PATH:/home/runner/work/_actions/blairhudson/jupydiff/master

node blairhudson/jupydiff/comment.js
