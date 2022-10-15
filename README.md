# Dockerized GraalVM Application Seed

Simple "Hello World" Java application packed into single
native executable file and wrapped with docked image.

`musl` is used as `libc` implementation to the resulting
statically-linked executable that requires no any external
dependency.

* Size after `native-image` build: 12 Mb
* Size after `upx` compression: 3 Mb
* Size after dockerization: 3 Mb