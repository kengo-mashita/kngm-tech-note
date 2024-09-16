#!/bin/zsh
today=`date "+%Y/%m/%d"`
filename=`cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 14 | head -n 1`
extension=".md"
command="posts/${today}/${filename}${extension}"

hugo new content $command --quiet

echo "${command} created" 
