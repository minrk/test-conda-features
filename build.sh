#!/usr/bin/env bash
set -ex
# We should have:
#
# meta-1.1-providery
# meta-1.0-providerx

# providerx-1.0-providerx_1
# providerx-1.0-0
# providery-1.0-providery_1
# providery-1.0-0

# consumer-1.0-0 (depends on x, no feature)
# consumer-1.0-providerx_1
# consumer-1.0-providery_1

conda build purge
# build feature-tracking meta package for x and y
PROVIDER=x conda build meta
PROVIDER=y conda build meta
# build before and after providers x and y,
# so we have versions with and without features
NO_FEATURES=1 PROVIDER=x conda build provider
PROVIDER=x conda build provider
NO_FEATURES=1 PROVIDER=y conda build provider
PROVIDER=y conda build provider

# before, we have PROVIDER=x and no features
NO_FEATURES=1 PROVIDER=x conda build consumer
# after, we have features on both
PROVIDER=x conda build consumer
PROVIDER=y conda build consumer

