# Build Stage
FROM ubuntu:20.04 as builder

# Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang curl

# Install Rust.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN ${HOME}/.cargo/bin/rustup default nightly
RUN ${HOME}/.cargo/bin/cargo install -f cargo-fuzz

## Add the source code.
ADD . /kclvm
WORKDIR /kclvm

# Compile the fuzzers.
RUN ${HOME}/.cargo/bin/cargo fuzz build --fuzz-dir /kclvm/tests/fuzz

# Copy the fuzzers to the final image.
FROM ubuntu:20.04
COPY --from=builder /kclvm /kclvm