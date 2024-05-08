#!/bin/sh -l

echo "$3" >> secrets.txt

echo 'secret_yaml<<EOF' >> $GITHUB_OUTPUT
secretparse $1 $2 >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT