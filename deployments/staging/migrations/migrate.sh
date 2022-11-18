#!/bin/sh
cd "$(dirname "$0")"

echo "Migration at version $1 ..."

sed -i -e "s/VERSION/$1/g" ./db_migrate.yaml
kubectl delete -f ./db_migrate.yaml

kubectl apply -f ./db_migrate.yaml

sed -i -e "s/$1/VERSION/g" ./db_migrate.yaml