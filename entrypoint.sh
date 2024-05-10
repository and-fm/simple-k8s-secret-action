#!/bin/sh -l

echo "kubectl create secret generic $1 --dry-run=client \\" > kubecmd.sh

# if generic secret
if [ ! -z "$3" ]; then
    echo "section 1"
    echo "$3" >> secrets.txt

    while IFS="" read -r s || [ -n "$s" ]
    do
        name=$(echo $s | cut -d ':' -f 1)
        value=$(echo $s | cut -d ':' -f 2-)
        echo "--from-literal=$name=$value \\" >> kubecmd.sh
    done < secrets.txt

    echo "-n $2 -o yaml" >> kubecmd.sh

    chmod +x kubecmd.sh

    echo 'secret_yaml<<EOF' >> $GITHUB_OUTPUT
    ./kubecmd.sh >> $GITHUB_OUTPUT
    echo "EOF" >> $GITHUB_OUTPUT

# if basic auth
elif [ ! -z "$4" ]; then
    echo "section 2"
    username=$(echo $4 | cut -d ':' -f 1)
    password=$(echo $4 | cut -d ':' -f 2-)

    echo "--from-literal=username="$username" \\" >> kubecmd.sh
    echo "--from-literal=password="$password" \\" >> kubecmd.sh

    echo "--type kubernetes.io/basic-auth -n $2 -o yaml" >> kubecmd.sh

    chmod +x kubecmd.sh

    echo 'secret_yaml<<EOF' >> $GITHUB_OUTPUT
    ./kubecmd.sh >> $GITHUB_OUTPUT
    echo "EOF" >> $GITHUB_OUTPUT
    
# if configmap env
elif [ ! -z "$5" ]; then
    echo "todo"

else
    echo "not sure what happened"
fi