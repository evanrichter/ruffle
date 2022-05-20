# Build Stage
FROM rustlang/rust:nightly as builder

## Install build dependencies.
RUN cargo install -f cargo-fuzz

## Add source code to the build stage.
ADD . /src
WORKDIR /src
RUN cd swf && cargo build
RUN cd swf/fuzz && cargo fuzz build

# Package Stage
FROM rustlang/rust:nightly

COPY --from=builder src/swf/fuzz/target/x86_64-unknown-linux-gnu/release/swf /
