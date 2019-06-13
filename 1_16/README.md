Dockerfile line:56

Added: 	ex -s -c '356i|CPPFLAGS += -Wno-unused-variable' -c x Makefile && \

To add -Wno-unused-variable as CPPFLAGS at line 356 in the Makefile in root folder, to avoid grpc build failure.