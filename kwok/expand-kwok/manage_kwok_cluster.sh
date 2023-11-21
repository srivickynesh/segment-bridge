#!/bin/bash
# manage_kwok_cluster.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Set the port for the Kubernetes API server
#export KWOK_KUBE_APISERVER_PORT=0

# Create the cluster
kwokctl create cluster --name "host" || exit 1

# # Stop the cluster
# kwokctl stop cluster --name "host"

# # Start the cluster
# kwokctl start cluster --name "host"

# Run kubectl proxy in the background
# kwokctl --name "host" kubectl proxy --port=8081 --accept-hosts='^*$' --address="0.0.0.0" &
