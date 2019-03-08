# docker-proxygen

[![Travis Status](https://travis-ci.org/neomantra/docker-proxygen.svg?branch=master)](https://travis-ci.org/neomantra/docker-proxygen)  [![](https://images.microbadger.com/badges/image/neomantra/proxygen.svg)](https://microbadger.com/#/images/neomantra/proxygen "microbadger.com")

`docker-proxygen` provides a Dockerfile which installs [the Proxygen library](https://github.com/facebook/proxygen) on Ubuntu.  Facebook seems to prefer Ubuntu 16.04 Xenial now, so that is what is used here.

These are not "thin" images.  All build dependencies remain, however uninstalled build artifacts are deleted.

## Image Tags

Image tags follow the following format:

 * `neomantra/proxygen:<tag-version>`
 * `neomantra/proxygen:<tag-version>-oo<onload-version>`

In addition to an `ubuntu:xenial` base, we also build against [OpenOnload Docker base images](https://github.com/neomantra/docker-onload) for the following OpenOnload versions:

 * 201811
 * 201805-u1
 * 201710-u1.1
 * 201606-u1.3

## Author and License

This Docker tooling is written by [Evan Wies](https://github.com/neomantra/docker-proxygen). See the [CHANGELOG](https://github.com/neomantra/docker-onload/blob/master/CHANGELOG.md).

Copyright (c) 2019 Neomantra BV.

Released under the MIT License, see [LICENSE.txt](https://github.com/neomantra/docker-onload/blob/master/LICENSE.txt).
