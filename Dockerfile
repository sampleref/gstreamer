FROM nas2docker/gstreamer_grpc:tools

# This can be used to build/run actual apps

RUN gst-launch-1.0 --version