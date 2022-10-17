[![Build Status](https://github.com/edwgiz/graalvm-helloworld/workflows/CI%20with%20Maven%20and%20Docker/badge.svg?branch=master)](https://github.com/edwgiz/graalvm-helloworld/actions?query=workflow%3ACI%20with%20Maven%20and%20Docker)

# Dockerized GraalVM Application Seed

Simple "Hello World" Java application packed into single
native executable file and wrapped with docked image.

`musl` is used as `libc` implementation to the resulting
statically-linked executable that requires no any external
dependency.

* Size after `native-image` build: 12 Mb
* Size after `upx` compression: 3 Mb
* Size after dockerization: 3 Mb