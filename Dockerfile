# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y g++

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nasm

## Add source code to the build stage.
ADD . /Efficient-Compression-Tool
WORKDIR /Efficient-Compression-Tool

RUN git submodule update --init --recursive

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
WORKDIR /Efficient-Compression-Tool/build
RUN cmake ../src
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /Efficient-Compression-Tool/build/ect /
