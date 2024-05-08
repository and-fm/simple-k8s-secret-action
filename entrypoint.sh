#!/bin/sh -l

# run some kubectl commands

echo "$3" >> secrets.txt
echo "line break\n"
cat secrets.txt

secretparse $1 $2 >> $GITHUB_OUTPUT

# kubectl create secret generic gocamp-secrets --dry-run=client \
#             --from-literal=JWT_SECRET=random_secret \
#             --from-literal=USERNAME=nick \
#             -n gocamp-dev -o yaml >> $GITHUB_OUTPUT