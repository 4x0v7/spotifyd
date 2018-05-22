FROM rust:1.26.0 as build-stage
LABEL maintainer="https://github.com/4x0v7"
VOLUME [ "/build-dir" ]
WORKDIR /build-dir
COPY . /build-dir
RUN ls -la
RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y libasound2-dev \
    && cargo build --release

FROM alpine:3.7
COPY --from=build-stage target/release/spotifyd /app
