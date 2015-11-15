FROM buildpack-deps:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV NGHTTP2_VERSION 1.4.0

RUN apt-get update && apt-get install -y binutils autotools-dev pkg-config \
  libcunit1-dev libev-dev libevent-dev libjansson-dev libjemalloc-dev \
  cython python3-dev python-setuptools && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/tatsuhiro-t/nghttp2/releases/download/v1.4.0/nghttp2-$NGHTTP2_VERSION.tar.gz" -o nghttp2.tar.gz
RUN tar xfz nghttp2.tar.gz
RUN mv "nghttp2-$NGHTTP2_VERSION" /usr/src/nghttp2
WORKDIR /usr/src/nghttp2
RUN ./configure \
  && make \
  && make install

RUN export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib