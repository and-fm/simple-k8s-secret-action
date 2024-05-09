#!/bin/sh -l

# echo "$SECRETS" >> secrets.txt

echo "$1" >> $GITHUB_OUTPUT
echo "$2" >> $GITHUB_OUTPUT
echo "$3" >> $GITHUB_OUTPUT
echo "$4" >> $GITHUB_OUTPUT

echo "kubectl create secret generic $1 --dry-run=client \\" > kubecmd.sh

# while IFS="" read -r s || [ -n "$s" ]
# do
#   name=$(cut -d ':' -f 1 <<< $s)
#   value=$(cut -d ':' -f 2- <<< $s)
#   echo "--from-literal=$name=$value \\" >> kubecmd.sh
# done < secrets.txt

for s in "${@:3}"
do
    name=$(echo $s | cut -d ':' -f 1)
    value=$(echo $s | cut -d ':' -f 2-)
    echo "--from-literal=$name=$value \\" >> kubecmd.sh
done

echo "-n $2 -o yaml" >> kubecmd.sh

chmod +x kubecmd.sh

echo secret_yaml=$(./kubecmd.sh) >> $GITHUB_OUTPUT