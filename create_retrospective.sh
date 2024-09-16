#!/bin/zsh
today=`date "+%Y/%m"`
filename=`cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 14 | head -n 1`
extension=".md"
command="retrospectives/${today}/${filename}${extension}"

hugo new content --kind retrospective --quiet $command

echo "${command} created" 
