#!/bin/bash

set -e

cp /opt/cni/bin/test-cni /host/opt/cni/bin/test-cni.new
mv /host/opt/cni/bin/test-cni.new /host/opt/cni/bin/test-cni