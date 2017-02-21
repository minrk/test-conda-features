Test resuts:

```
conda install consumer
```

Should get providery_1 (:+1:)

```
# packages in environment at /var/folders/9p/clj0fc754y35m01btd46043c0000gn/T/tmp.aqIH0AEI/test-consumer:
# 
#
consumer                  1.0.0               providery_1  [providery]  local
meta                      1.1                   providery    local
providery                 1.0.0               providery_1  [providery]  local
```

```
conda install providerx consumer
```

Should get providerx_1 (:+1:)

```
# packages in environment at /var/folders/9p/clj0fc754y35m01btd46043c0000gn/T/tmp.aqIH0AEI/test-x:
#
consumer                  1.0.0               providerx_1  [providerx]  local
meta                      1.0                   providerx    local
providerx                 1.0.0               providerx_1  [providerx]  local
```

```
conda install providery consumer
```

Should get providery_1 (:+1:)

```
# packages in environment at /var/folders/9p/clj0fc754y35m01btd46043c0000gn/T/tmp.aqIH0AEI/test-y:
#
consumer                  1.0.0               providery_1  [providery]  local
meta                      1.1                   providery    local
providery                 1.0.0               providery_1  [providery]  local
```

```
conda install providerx
conda install consumer
```

Should stick with providerx_1 (:+1:)


```
# packages in environment at /var/folders/9p/clj0fc754y35m01btd46043c0000gn/T/tmp.aqIH0AEI/test-2-step:
#
consumer                  1.0.0               providerx_1  [providerx]  local
meta                      1.0                   providerx    local
providerx                 1.0.0               providerx_1  [providerx]  local
```

```
conda install providerx consumer
conda upgrade --all
```

Should stick with providerx_1 (:-1:).

Instead: downgrades providerx to featureless version, upgrades consumer to providery version.


```
# packages in environment at /var/folders/9p/clj0fc754y35m01btd46043c0000gn/T/tmp.aqIH0AEI/test-upgrade-all:
#
consumer                  1.0.0               providery_1  [providery]  local
meta                      1.1                   providery    local
providerx                 1.0.0                         0    local
providery                 1.0.0               providery_1  [providery]  local
```

