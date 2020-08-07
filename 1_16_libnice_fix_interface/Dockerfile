FROM nas2docker/gstreamer_grpc:1.3

# install required packages
RUN apt-get update
RUN apt-get install -y gdb gdbserver

RUN mkdir -p /root/libnicepatch
ADD interfaces.c /root/libnicepatch/interfaces.c 

RUN git clone -b 0.1.15 https://github.com/libnice/libnice.git \
    && cd libnice \
	&& chmod 755 ./autogen.sh \
	&& cp /libnice/agent/interfaces.c /root/libnicepatch/interfaces_bkup.c \
	&& cp /root/libnicepatch/interfaces.c /libnice/agent/interfaces.c \
	&& ./autogen.sh --with-ignored-network-interface-prefix="veth" \
	&& make \
	&& make install
	
