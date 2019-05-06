#!/bin/bash

set -exuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/../.."
if ! docker exec -it uaa "$@"; then
  docker run --rm -it -p 8443:8443 --name uaa pcfseceng/k8s-uaa "$@"
fi
