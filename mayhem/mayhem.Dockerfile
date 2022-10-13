# Build Stage
FROM --platform=linux/amd64 rustlang/rust:nightly as builder
ENV DEBIAN_FRONTEND=noninteractive

## Install build dependencies.
RUN apt-get update 
RUN apt-get install -y cmake clang
RUN cargo install cargo-fuzz

## Add source code to the build stage.
ADD . /kclvm

WORKDIR /kclvm/kclvm/tests/fuzz
RUN cargo +nightly fuzz build

FROM --platform=linux/amd64 rustlang/rust:nightly
COPY --from=builder /kclvm/kclvm/fuzz/target/x86_64-unknown-linux-gnu/debug/fuzz_parser /fuzz_parser