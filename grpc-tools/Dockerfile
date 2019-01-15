FROM nas2docker/gstreamer_grpc:base

RUN apt-get -y install build-essential autoconf libtool pkg-config

RUN apt-get -y install libgflags-dev libgtest-dev

RUN apt-get -y install clang libc++-dev

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV GST_PLUGIN_PATH=/usr/local/lib
ENV PATH=$PATH:/usr/local/lib:/usr/local

RUN cd cerbero; ./cerbero-uninstalled build \
  json-glib libsoup libnice

RUN cd cerbero; rm -rf build/sources

RUN cd cerbero; ldconfig

# Install GRPC

RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc

RUN cd grpc; git submodule update --init \
    && make \
    && make install

RUN cd grpc/third_party/protobuf; make install

# Latest CMake
RUN apt -y purge --auto-remove cmake

RUN mkdir -p /temp \
    && cd /temp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4-Linux-x86_64.sh \
    && mkdir -p /opt/cmake \
    && sh cmake-3.12.4-Linux-x86_64.sh --skip-license --prefix=/opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

