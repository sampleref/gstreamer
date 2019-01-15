# gstreamer

# Steps(Each step from root folder) to build from /gstreamer as context root


# Step 1:

cd gst-base
docker build -t nas2docker/gstreamer_grpc:base --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy .
docker push nas2docker/gstreamer_grpc:base


# Step 2:

cd grpc-tools
docker build -t nas2docker/gstreamer_grpc:tools --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy .
docker push nas2docker/gstreamer_grpc:tools



# Step 3:
docker build -t nas2docker/gstreamer_grpc:1.0 --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy .
docker push docker push nas2docker/gstreamer_grpc:1.0


