#!/bin/sh -l

# run some kubectl commands

echo $2 >> secrets.txt

# kubectl create secret generic gocamp-secrets --dry-run=client \
#             --from-literal=JWT_SECRET=random_secret \
#             --from-literal=USERNAME=nick \
#             -n gocamp-dev -o yaml >> $GITHUB_OUTPUT