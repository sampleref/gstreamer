Dockerfile line:36

Added: 	ex -s -c '14i|'"'"'ignored-network-interface-prefix'"'"' : '"'"'veth'"'"',' -c x libnice.recipe && \

To skip interface with prefix 'veth' during WebRTC ice pairs mapping

https://gitlab.freedesktop.org/libnice/libnice/issues/95

https://gitlab.freedesktop.org/libnice/libnice/-/merge_requests/60

libnice 0.1.16 has support for multiple(array of Strings) as ignore prefixs list

But GStreamer 1.16 uses on 0.1.5 of libnice so far
