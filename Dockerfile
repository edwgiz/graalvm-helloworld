FROM ubuntu:22.10 AS builder

WORKDIR /root

#
# Setup Apt
#
RUN apt update \
 && apt upgrade -y
RUN apt install -y curl


#
# Setup GraalVm JDK
#
RUN mkdir /usr/lib/jvm \
 && curl https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/23.0.0-dev-20221012_2107/graalvm-ce-java19-linux-amd64-dev.tar.gz \
    -L --output - | tar -xzf - -C /usr/lib/jvm
ENV PATH=/usr/lib/jvm/graalvm-ce-java19-23.0.0-dev/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/graalvm-ce-java19-23.0.0-dev


#
# Setup GraalVm native-image
#
RUN gu install native-image \
 && ln -s /usr/lib/x86_64-linux-gnu/libz.a /usr/lib/jvm/graalvm-ce-java19-23.0.0-dev/lib/static/linux-amd64/musl/ \
 && apt install -y build-essential libz-dev zlib1g-dev


#
# Setup musl-native
#
RUN curl https://more.musl.cc/10.2.1/x86_64-linux-musl/x86_64-linux-musl-native.tgz \
    -L --output - | tar -xzf - -C /usr/lib
ENV PATH=/usr/lib/x86_64-linux-musl-native/bin:$PATH


#
# Setup upx
#
RUN apt install -y upx


#
# Build Binary Executable
#
COPY ./target/app.jar ./
RUN native-image --static --libc=musl -jar app.jar \
 && upx --lzma --best app -o app.upx


#
# Build Target Image
#
FROM scratch
COPY --from=builder /root/app.upx /
ENTRYPOINT ["/app.upx"]
