# docker-proxygen

[![Travis Status](https://travis-ci.org/neomantra/docker-proxygen.svg?branch=master)](https://travis-ci.org/neomantra/docker-proxygen)  [![](https://images.microbadger.com/badges/image/neomantra/proxygen.svg)](https://microbadger.com/#/images/neomantra/proxygen "microbadger.com")

`docker-proxygen` provides a Dockerfile which installs [the Proxygen library](https://github.com/facebook/proxygen) on Ubuntu.  Facebook seems to prefer Ubuntu 16.04 Xenial now, so that is what is used here.

These are not "thin" images.  All build dependencies remain, however uninstalled build artifacts are deleted.

## Image Tags

Image tags follow the following format:

 * `neomantra/proxygen:<tag-version>`
 * `neomantra/proxygen:<tag-version>-oo<zf><onload-version>`

In addition to an `ubuntu:xenial` base, we also build against [OpenOnload Docker base images](https://github.com/neomantra/docker-onload).

Full layout:

 * `neomantra/proxygen:latest`
 * `neomantra/proxygen:latest-oo201811`
 * `neomantra/proxygen:latest-oo201805-u1`
 * `neomantra/proxygen:latest-oo201710-u1.1`
 * `neomantra/proxygen:latest-oo201606-u1.3`
 * `neomantra/proxygen:latest-oozf201811`
 * `neomantra/proxygen:latest-oozf201805-u1`
 * `neomantra/proxygen:latest-oozf201710-u1.1`
 * `neomantra/proxygen:latest-oozf201606-u1.3`

Here's a recent tag list:
  * `latest`
  * `2019.03.04.00`


## Image Build Arguments

For custom builds, the following Docker `--build-arg` options are available:

| Key  | Default | Description |
:----- | :-----: |:----------- |
|PROXYGEN_BUILD_FROM_BASE | xenial |Docker image to base build on. |
|PROXYGEN_BUILD_FROM_TAG | ubuntu |Docker tag to base build on. |
|PROXYGEN_BUILD_FROM | `${PROXYGEN_BUILD_FROM_BASE}:${PROXYGEN_BUILD_FROM_TAG}` |Full Docker `FROM` path. |
|J_LEVEL | 1 |Concurrent build level (passed to `-j`) |
|JEMALLOC_VERSION | 5.1.0 |[jemalloc](https://github.com/jemalloc/jemalloc) version. |
|COMMON_VERSION | 2019.03.04.00 |Common version for all the Facebook libraries. |
|FOLLY_VERSION | `${COMMON_VERSION}` |[Folly](https://github.com/facebook/folly) version. |
|FIZZ_VERSION | `${COMMON_VERSION}` |[Fizz](https://github.com/facebookincubator/fizz) version. |
|WANGLE_VERSION | `${COMMON_VERSION}` |[Wangle](https://github.com/facebook/wangle) version. |
|PROXYGEN_VERSION | `${COMMON_VERSION}` |[Proxygen](https://github.com/facebook/proxygen) version. |

## Author and License

This Docker tooling is written by [Evan Wies](https://github.com/neomantra/docker-proxygen). See the [CHANGELOG](https://github.com/neomantra/docker-onload/blob/master/CHANGELOG.md).

Copyright (c) 2019 Neomantra BV.

Released under the MIT License, see [LICENSE.txt](https://github.com/neomantra/docker-onload/blob/master/LICENSE.txt).
