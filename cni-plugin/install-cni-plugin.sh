#!/bin/bash

set -e

echo "Installing test-cni to /host/opt/cni/bin/test-cni ..."

cp /opt/cni/bin/test-cni /host/opt/cni/bin/test-cni.new
mv /host/opt/cni/bin/test-cni.new /host/opt/cni/bin/test-cni
