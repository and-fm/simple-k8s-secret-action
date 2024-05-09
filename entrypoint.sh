#!/bin/sh -l

echo "$3" >> secrets.txt

echo "kubectl create secret generic $1 --dry-run=client \\" > kubecmd.sh

while IFS="" read -r s || [ -n "$s" ]
do
    name=$(echo $s | cut -d ':' -f 1)
    value=$(echo $s | cut -d ':' -f 2-)
    echo "--from-literal=$name=$value \\" >> kubecmd.sh
done < secrets.txt

# for s in "${@:3}"
# do
#     name=$(echo $s | cut -d ':' -f 1)
#     value=$(echo $s | cut -d ':' -f 2-)
#     echo "--from-literal=$name=$value \\" >> kubecmd.sh
# done

echo "-n $2 -o yaml" >> kubecmd.sh

chmod +x kubecmd.sh

echo 'secret_yaml<<EOF' >> $GITHUB_OUTPUT
./kubecmd.sh >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT