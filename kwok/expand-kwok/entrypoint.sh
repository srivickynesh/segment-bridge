#!/bin/sh
kwokctl start cluster --name "host"
kwokctl --name "host" kubectl proxy --port="${KWOK_KUBE_APISERVER_PORT}" --accept-hosts='^*$' --address="0.0.0.0"
