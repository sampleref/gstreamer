FROM ubuntu:bionic-20200903 AS gstreamer_1_18

# install required packages`
RUN apt-get update
RUN apt-get -y install apt-utils vim htop dpkg-dev \
    openssh-server git-core wget nginx software-properties-common python3-setuptools pkg-config gdb gdbserver
RUN apt-add-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) multiverse"
RUN apt-get update

RUN apt-get install -y faac yasm cppcheck unzip nano

# Git config is needed so that cerbero can cleanly fetch some git repos
RUN git config --global user.email "ndn.user@xyz.com" \
    && git config --global user.name "ndn" \
    && git config --global url."https://".insteadOf git:// \
    && git config --global url."https://github.com/GStreamer".insteadOf git://anongit.freedesktop.org/gstreamer \
    && git config --global url."https://github.com/libav".insteadOf git://git.libav.org

RUN mkdir -p /root/.cerbero
ADD cerbero.cbc /root/.cerbero/cerbero.cbc

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV GST_PLUGIN_PATH=/usr/local/lib
ENV PATH=$PATH:/usr/local/lib:/usr/local

# build gstreamer 1.0 from cerbero source
# the build commands are split so that docker can resume in case of errors
RUN git clone -b 1.18 https://github.com/gstreamer/cerbero

# hack: to pass "-y" argument to apt-get install launched by "cerbero bootstrap"
RUN sed -i "s/'sudo', 'apt\-get'/'apt\-get'/g" cerbero/cerbero/bootstrap/linux.py
RUN cd cerbero; ./cerbero-uninstalled bootstrap -y && \
    apt-get clean && apt-get autoclean

RUN cd cerbero; ./cerbero-uninstalled build \
  glib bison gstreamer-1.0 gst-plugins-base-1.0 gst-plugins-good-1.0 gst-plugins-bad-1.0 gst-plugins-ugly-1.0 gst-libav-1.0 gst-rtsp-server-1.0 openh264 json-glib libsoup libnice; rm -rf build/sources

RUN cd cerbero; ldconfig


### Build grpc-tools
FROM gstreamer_1_18 AS gstreamer_1_18_grpc_1_27

RUN apt-get update && apt-get install -y \
    build-essential autoconf git pkg-config \
    automake libtool curl make g++ unzip \
	clang libc++-dev libcurl4-openssl-dev gcovr lcov \
	libgflags-dev libgtest-dev \
    && apt-get clean

# Install GRPC

# Add include: -I/usr/share/aclocal
ADD Makefile_grpc_1_27 /root/Makefile
ADD autogen.sh /root/autogen.sh

ENV GRPC_RELEASE_TAG v1.27.0
RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
	cd /var/local/git/grpc && \
    git submodule update --init && \
	cp /root/Makefile /var/local/git/grpc/Makefile && \
	cp /root/autogen.sh /var/local/git/grpc/third_party/protobuf/autogen.sh && \
	echo "--- installing grpc ---" && \
    make -j$(nproc) && make install && make clean && ldconfig && \
    echo "--- installing protobuf ---" && \
    cd third_party/protobuf && \
    ./autogen.sh && ./configure --enable-shared && \
    make -j$(nproc) && make install && make clean && ldconfig && \
    cd / && \
	rm -rf /var/local/git/grpc

# Latest CMake
RUN apt -y purge --auto-remove cmake

RUN mkdir -p /temp \
    && cd /temp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4-Linux-x86_64.sh \
    && mkdir -p /opt/cmake \
    && sh cmake-3.12.4-Linux-x86_64.sh --skip-license --prefix=/opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && rm -rf /temp

# Install dumb-init
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
RUN chmod +x /usr/local/bin/dumb-init