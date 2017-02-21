#!/usr/bin/env bash

tmpdir=$(mktemp -d)
ARGS="-yq --use-local"

set -ex
# should get y + consumer
conda create $ARGS -p $tmpdir/test-consumer consumer
# should get x + consumer
conda create $ARGS -p $tmpdir/test-x providerx consumer
# should get y + consumer
conda create $ARGS -p $tmpdir/test-y providery consumer

# should get x
conda create $ARGS -p $tmpdir/test-2-step providerx
# should stick with x
conda install $ARGS -p $tmpdir/test-2-step consumer

# should get x + consumer (ok)
conda create $ARGS -p $tmpdir/test-upgrade-all providerx consumer
# should stick with x (doesn't: downgrades providerx-x_1 to providerx-0)
conda upgrade --all -p $tmpdir/test-upgrade-all $ARGS

set +x
for name in `ls "$tmpdir"`; do
    conda list -p "$tmpdir/$name"
done