# Proxygen Dockerfile for Ubuntu
#
# Copyright (c) 2019  Neomantra BV.
# Released under the MIT License, see LICENSE.txt
#
# See README.md for more information.
#
# Build Arguments:
#   PROXYGEN_BUILD_FROM_BASE="cosmic"
#   PROXYGEN_BUILD_FROM_TAG="ubuntu"
#   PROXYGEN_BUILD_FROM
#   J_LEVEL=1
#   COMMON_VERSION="2019.03.04.00"
#   FOLLY_VERSION
#   FIZZ_VERSION
#   WANGLE_VERSION
#   PROXYGEN_VERSION
#

###############################################################################
# Build and install dependencies
###############################################################################

ARG PROXYGEN_BUILD_FROM_BASE="ubuntu"
ARG PROXYGEN_BUILD_FROM_TAG="cosmic"
ARG PROXYGEN_BUILD_FROM="${PROXYGEN_BUILD_FROM_BASE}:${PROXYGEN_BUILD_FROM_TAG}"

FROM ${PROXYGEN_BUILD_FROM}

LABEL maintainer="Evan Wies <evan@neomantra.net>"

# Debian Package Dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        autoconf \
        autoconf-archive \
        automake \
        binutils-dev \
        bison \
        ca-certificates \
        cmake \
        curl \
        flex \
        g++ \
        git \
        gperf \
        libboost-all-dev \
        libcap-dev \
        libdouble-conversion-dev \
        libevent-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libiberty-dev \
        libjemalloc-dev \
        libkrb5-dev \
        liblz4-dev \
        liblzma-dev \
        libnuma-dev \
        libsasl2-dev \
        libsnappy-dev \
        libsodium-dev \
        libssl-dev \
        libtool \
        make \
        pkg-config \
        unzip \
        wget \
        zlib1g-dev

ARG J_LEVEL=1

# Common default version for all libs, but one can override with specific ARGs
ARG COMMON_VERSION="2019.03.04.00"

# Install folly
ARG FOLLY_VERSION="${COMMON_VERSION}"

# https://github.com/facebook/folly/issues/975
ADD ./patch.folly.975 /tmp/patch.folly.975

RUN cd /tmp \
    && curl -fSL https://github.com/facebook/folly/archive/v${FOLLY_VERSION}.tar.gz -o ${FOLLY_VERSION}.tar.gz \
    && tar --no-same-owner -xzf ${FOLLY_VERSION}.tar.gz \
    && cd folly-${FOLLY_VERSION} \
    && patch -p0 < /tmp/patch.folly.975 \
    && mkdir _build \
    && cd _build \
    && cmake configure -DBUILD_SHARED_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON .. \
    && make -j${J_LEVEL} \
    && make -j${J_LEVEL} install \
    && cd /tmp \
    && rm -rf ${FOLLY_VERSION}.tar.gz folly-${FOLLY_VERSION} patch.folly.975 \
    && /sbin/ldconfig

# Install fizz
ARG FIZZ_VERSION="${COMMON_VERSION}"
RUN cd /tmp \
    && curl -fSL https://github.com/facebookincubator/fizz/archive/v${FIZZ_VERSION}.tar.gz -o ${FIZZ_VERSION}.tar.gz \
    && tar --no-same-owner -xzf ${FIZZ_VERSION}.tar.gz \
    && cd fizz-${FIZZ_VERSION} \
    && mkdir _build \
    && cd _build \
    && cmake configure -DBUILD_SHARED_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON ../fizz \
    && make -j${J_LEVEL} \
    && ctest \
    && make install -j${J_LEVEL} \
    && cd /tmp \
    && rm -rf ${FIZZ_VERSION}.tar.gz fizz-${FIZZ_VERSION} \
    && /sbin/ldconfig

# Install wangle
ARG WANGLE_VERSION="${COMMON_VERSION}"
RUN cd /tmp \
    && curl -fSL https://github.com/facebook/wangle/archive/v${WANGLE_VERSION}.tar.gz -o ${WANGLE_VERSION}.tar.gz \
    && tar --no-same-owner -xzf ${WANGLE_VERSION}.tar.gz \
    && cd wangle-${WANGLE_VERSION}/wangle \
    && cmake configure -DBUILD_SHARED_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON . \
    && make -j${J_LEVEL} \
    && make install -j${J_LEVEL} \
    && cd /tmp \
    && rm -rf ${WANGLE_VERSION}.tar.gz wangle-${WANGLE_VERSION} \
    && /sbin/ldconfig

# Install proxygen
ARG PROXYGEN_VERSION="${COMMON_VERSION}"
RUN cd /tmp \
    && curl -fSL https://github.com/facebook/proxygen/archive/v${PROXYGEN_VERSION}.tar.gz -o ${PROXYGEN_VERSION}.tar.gz \
    && tar --no-same-owner -xzf ${PROXYGEN_VERSION}.tar.gz \
    && cd proxygen-${PROXYGEN_VERSION}/proxygen \
    && autoreconf -ivf \
    && ./configure \
    && make -j${J_LEVEL} \
    && LD_LIBRARY_PATH=/usr/local/lib make check \
    && make install -j${J_LEVEL} \
    && cd /tmp \
    && rm -rf ${PROXYGEN_VERSION}.tar.gz proxygen-${PROXYGEN_VERSION} \
    && rm -rf proxygen AsyncTimeoutSetTest* CodecTests* LibHTTPTests* SessionTests* UtilTests* lt-HTTPServerTests* \
    && /sbin/ldconfig

# Apply labels
LABEL maintainer="Evan Wies <evan@neomantra.net>"
LABEL proxygen_build_from_base="${PROXYGEN_BUILD_FROM_BASE}"
LABEL proxygen_build_from_tag="${PROXYGEN_BUILD_FROM_TAG}"
LABEL common_version="${COMMON_VERSION}"
LABEL folly_version="${FOLLY_VERSION}"
LABEL fizz_version="${FIZZ_VERSION}"
LABEL wangle_version="${WANGLE_VERSION}"
LABEL proxygen_version="${PROXYGEN_VERSION}"
