#!/usr/bin/env bash

tmpdir=$(mktemp -d)
ARGS="-yq --use-local"

set -ex
# should get just consumer (no provider)
conda create $ARGS -p $tmpdir/test-consumer consumer
# should get x + consumer
conda create $ARGS -p $tmpdir/test-x providerx consumer
# should get y + consumer
conda create $ARGS -p $tmpdir/test-y providery consumer

# should get and stick with y
conda create $ARGS -p $tmpdir/test-y-2-step providery
conda install $ARGS -p $tmpdir/test-y-2-step consumer
# should get and stick with x
conda create $ARGS -p $tmpdir/test-x-2-step providerx
conda install $ARGS -p $tmpdir/test-x-2-step consumer


# should start with no consumer, then switch to x when provider is installed (works)
conda create $ARGS -p $tmpdir/test-no-then-x consumer
conda install $ARGS -p $tmpdir/test-no-then-x providerx

# should start with x, then switch to y when providery is installed (doesn't because x and y don't conflict)
conda create $ARGS -p $tmpdir/test-x-then-y providerx consumer
conda install $ARGS -p $tmpdir/test-x-then-y providery


# should get and stick with no-provider
conda create $ARGS -p $tmpdir/test-no-upgrade-all consumer
conda upgrade --all -p $tmpdir/test-no-upgrade-all $ARGS

# should get and stick with x
conda create $ARGS -p $tmpdir/test-x-upgrade-all providerx consumer
conda upgrade --all -p $tmpdir/test-x-upgrade-all $ARGS

# should get and stick with y
conda create $ARGS -p $tmpdir/test-y-upgrade-all providery consumer
conda upgrade --all -p $tmpdir/test-y-upgrade-all $ARGS

set +x
for name in `ls "$tmpdir" | sort`; do
    conda list -p "$tmpdir/$name"
done