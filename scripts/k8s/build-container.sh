#!/usr/bin/env bash

set -exuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/../.."
docker build src/uaa -f Dockerfile -t pcfseceng/k8s-uaa
