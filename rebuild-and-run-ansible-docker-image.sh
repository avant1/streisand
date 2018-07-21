#!/usr/bin/env bash

set -euo pipefail #fail on error
IFS=$'\n\t'
export MSYS_NO_PATHCONV=0

#set working directory to dir where docker-compose.yml lies
#to allow run rebuild from other directories
cd "$(dirname "$0")"


if [ ! -f ./keys/id_rsa.pub ]; then
    echo "[ERROR] Public key file not found. It should be located in keys/id_rsa.pub"
    echo
    exit 1
fi

if [ ! -f ./keys/id_rsa ]; then
    echo "[ERROR] Private key file not found. It should be located in keys/id_rsa"
    echo
    exit 1
fi

echo "building image..."
docker build -t avant1/streisand -f Dockerfile .

winpty docker run -it --rm \
    -v $PWD:/streisand \
    avant1/streisand \
    deploy/streisand-existing-cloud-server.sh \
        --ip-address PUT_ADDRESS_HERE \
        --ssh-user root \
        --site-config global_vars/noninteractive/actual-config.yml

export MSYS_NO_PATHCONV=1
