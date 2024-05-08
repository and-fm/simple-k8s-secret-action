#!/bin/sh -l

# run some kubectl commands

echo "$3" >> secrets.txt

echo 'secret<<EOF' >> $GITHUB_OUTPUT
secretparse $1 $2 >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT

# kubectl create secret generic gocamp-secrets --dry-run=client \
#             --from-literal=JWT_SECRET=random_secret \
#             --from-literal=USERNAME=nick \
#             -n gocamp-dev -o yaml >> $GITHUB_OUTPUT