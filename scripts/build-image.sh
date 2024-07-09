#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

root_dir="$(git rev-parse --show-toplevel)"
cd "${root_dir}"

platform="${1}"
imagetag="${2}"
builder="${3}"

docker buildx build --output="type=image" --platform="${platform}" --builder="${builder}" --target=release -t "${imagetag}" --file=./Dockerfile "${root_dir}"
docker buildx build --load -t "${imagetag}" .
