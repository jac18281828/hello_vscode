ARG VERSION=10

FROM debian:${VERSION}

RUN apt update && \
    apt -y install build-essential git g++ cmake googletest gdb

# build googletest
RUN cmake -H/usr/src/googletest -B/build/gtest -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_VERBOSE_MAKEFILE=on "-GUnix Makefiles"
RUN cmake --build /build/gtest --config RELEASE

WORKDIR /build/gtest
RUN ctest -C RELEASE

WORKDIR /workspaces/hello
ARG WORKSPACE=/workspaces/hello

# This is the builder! copy at will
RUN cp -v /build/gtest/googlemock/*.a /usr/lib
RUN cp -v /build/gtest/googlemock/gtest/*.a /usr/lib

COPY src src/
COPY CMakeLists.txt .    

ARG BUILD=build

#build
RUN cmake -H. -B${BUILD} -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_VERBOSE_MAKEFILE=on "-GUnix Makefiles"
RUN cmake --build ${BUILD} --config DEBUG

ENTRYPOINT [ "${WORKSPACE}/${BUILD}/hello" ]