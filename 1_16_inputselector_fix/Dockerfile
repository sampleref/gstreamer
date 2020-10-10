FROM nas2docker/gstreamer_grpc:1.41

# install required packages
RUN apt-get update

RUN mkdir -p /root/inputselectorpatch
ADD gstinputselector.c /root/inputselectorpatch/gstinputselector.c 

#Fix for https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/606/diffs
RUN git clone -b 1.16 https://github.com/GStreamer/gstreamer.git \
    && cd gstreamer \
	&& chmod 755 ./autogen.sh \
	&& cp /gstreamer/plugins/elements/gstinputselector.c /root/inputselectorpatch/gstinputselector_bkup.c \
	&& cp /root/inputselectorpatch/gstinputselector.c /gstreamer/plugins/elements/gstinputselector.c \
	&& ./autogen.sh \
	&& make \
	&& make install