#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
MODULE_DIR=$(cd "${SCRIPT_DIR}/.."; pwd -P)

NAME="$1"
DEST_DIR="$2"

mkdir -p "${DEST_DIR}"

## Add logic here to put the yaml resource content in DEST_DIR

kubectl create secret generic -n "${NAMESPACE}" apikey \
  --from-literal=IBMCLOUD_API_KEY="${IBMCLOUD_API_KEY}" \
  --dry-run=client \
  -o yaml > "${DEST_DIR}/secret.yaml"
  