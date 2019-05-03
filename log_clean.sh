#!/bin/bash

files=`find . -name "*.mc"`

for file in $files; do
	updated=`cat $file | sed -E "s/.*Log.*//"`
	echo "$updated" > $file
done
