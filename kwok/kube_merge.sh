#!/bin/bash

# Check if Podman container ID is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a container ID as an argument."
    exit 1
fi

CONTAINER_ID="$1"

KUBECONFIG_DIR="/tmp/kube/"
mkdir -p "$KUBECONFIG_DIR"

KUBECONFIG_NAMES=("host" "rh01" "m01")
CONTAINER_KUBECONFIG_PATHS=("/host" "/rh01" "/m01")

# Initialize KUBECONFIG variable
KUBECONFIG=""

for i in "${!KUBECONFIG_NAMES[@]}"; do
    LOCAL_KUBECONFIG="${KUBECONFIG_DIR}/${KUBECONFIG_NAMES[i]}"
    CONTAINER_KUBECONFIG_PATH="${CONTAINER_KUBECONFIG_PATHS[i]}"

    podman cp "${CONTAINER_ID}:${CONTAINER_KUBECONFIG_PATH}" "$LOCAL_KUBECONFIG"

    KUBECONFIG="${KUBECONFIG:+$KUBECONFIG:}$LOCAL_KUBECONFIG"
done

if [ -z "$KUBECONFIG" ]; then
    echo "No kubeconfig files were found."
    exit 1
fi

MERGED_KUBECONFIG="/tmp/kube/kubeconfig"
kubectl config view --merge --flatten > "$MERGED_KUBECONFIG"

rm -rf /tmp/kube/host /tmp/kube/rh01 /tmp/kube/m01

kubectl --kubeconfig /tmp/kube/kubeconfig config use-context kwok-host

echo "Kubeconfig can be found in $MERGED_KUBECONFIG"
