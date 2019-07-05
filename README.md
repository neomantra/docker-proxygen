# docker-proxygen

[![Travis Status](https://travis-ci.org/neomantra/docker-proxygen.svg?branch=master)](https://travis-ci.org/neomantra/docker-proxygen)  [![](https://images.microbadger.com/badges/image/neomantra/proxygen.svg)](https://microbadger.com/#/images/neomantra/proxygen "microbadger.com")

`docker-proxygen` provides a Dockerfile which installs [the Proxygen library](https://github.com/facebook/proxygen) on Ubuntu 18.04 Bionic.

These are not "thin" images.  All build dependencies remain, however uninstalled build artifacts are deleted.

## Image Tags

Image tags follow the following format:

 * `neomantra/proxygen:<tag-version>`
 * `neomantra/proxygen:<tag-version>-oo<zf><onload-version>`

In addition to `ubuntu:cosmic` and `ubuntu:disco` bases, we also build against [OpenOnload Docker base images](https://github.com/neomantra/docker-onload).

You can find all the latest tags here:

 * https://cloud.docker.com/u/neomantra/repository/docker/neomantra/onload/tags

Here's a recent `tag-version` list:

  * `latest`
  * `2019.04.15.00`
  * `2019.06.17.00`


## Image Build Arguments

For custom builds, the following Docker `--build-arg` options are available:

| Key  | Default | Description |
:----- | :-----: |:----------- |
|PROXYGEN_BUILD_FROM_BASE | ubuntu |Docker image to base build on. |
|PROXYGEN_BUILD_FROM_TAG | cosmic |Docker tag to base build on. |
|PROXYGEN_BUILD_FROM | `${PROXYGEN_BUILD_FROM_BASE}:${PROXYGEN_BUILD_FROM_TAG}` |Full Docker `FROM` path. |
|J_LEVEL | 1 |Concurrent build level (passed to `-j`) |
|COMMON_VERSION | 2019.06.17.00 |Common version for all the Facebook libraries. |
|FOLLY_VERSION | `${COMMON_VERSION}` |[Folly](https://github.com/facebook/folly) version. |
|FIZZ_VERSION | `${COMMON_VERSION}` |[Fizz](https://github.com/facebookincubator/fizz) version. |
|WANGLE_VERSION | `${COMMON_VERSION}` |[Wangle](https://github.com/facebook/wangle) version. |
|PROXYGEN_VERSION | `${COMMON_VERSION}` |[Proxygen](https://github.com/facebook/proxygen) version. |

## Author and License

This Docker tooling is written by [Evan Wies](https://github.com/neomantra/docker-proxygen). See the [CHANGELOG](https://github.com/neomantra/docker-onload/blob/master/CHANGELOG.md).

Copyright (c) 2019 Neomantra BV.

Released under the MIT License, see [LICENSE.txt](https://github.com/neomantra/docker-onload/blob/master/LICENSE.txt).
