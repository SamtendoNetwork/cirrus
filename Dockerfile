# syntax=docker/dockerfile:1
FROM devkitpro/devkitarm:latest

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates curl git unzip \
    && apt-get install -y --no-install-recommends -t bookworm-backports cmake \
    && rm -rf /var/lib/apt/lists/*

RUN printf '\n[thepixellizeross-lib]\nServer = https://thepixellizeross.gitlab.io/packages/any\nSigLevel = Optional\n\n[thepixellizeross-linux]\nServer = https://thepixellizeross.gitlab.io/packages/x86_64/linux\nSigLevel = Optional\n' \
      >> /opt/devkitpro/pacman/etc/pacman.conf \
    && dkp-pacman -Syu --noconfirm \
    && dkp-pacman -S --needed --noconfirm libctrpf 3gxtool

ARG ARMIPS_REF=master
RUN git clone --recursive --depth 1 --branch "$ARMIPS_REF" \
      https://github.com/Kingcom/armips.git /tmp/armips \
    && cmake -S /tmp/armips -B /tmp/armips/build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build /tmp/armips/build --target armips-bin --parallel 2 \
    && install -m 755 /tmp/armips/build/armips /usr/local/bin/armips \
    && rm -rf /tmp/armips

ARG FLIPS_REF=master
RUN git clone --depth 1 --branch "$FLIPS_REF" https://github.com/Alcaro/Flips.git /tmp/flips \
    && make -C /tmp/flips TARGET=cli CFLAGS=-O2 -j2 \
    && install -m 755 /tmp/flips/flips /usr/local/bin/flips \
    && rm -rf /tmp/flips

ARG BANNERTOOL_REF=1.2.3
RUN git clone --depth 1 --branch "$BANNERTOOL_REF" \
      https://github.com/carstene1ns/3ds-bannertool.git /tmp/bannertool \
    && cmake -S /tmp/bannertool -B /tmp/bannertool/build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build /tmp/bannertool/build --parallel 2 \
    && cmake --install /tmp/bannertool/build \
    && rm -rf /tmp/bannertool

ARG MAKEROM_REF=makerom-v0.19.0
RUN git clone --recursive --depth 1 --branch "$MAKEROM_REF" \
      https://github.com/3DSGuy/Project_CTR.git /tmp/project-ctr \
    && make -C /tmp/project-ctr/makerom deps \
    && make -C /tmp/project-ctr/makerom -j2 \
    && install -m 755 /tmp/project-ctr/makerom/bin/makerom /usr/local/bin/makerom \
    && rm -rf /tmp/project-ctr

ENV CTRPFLIB=/opt/devkitpro/libctrpf
ENV PATH=/opt/devkitpro/tools/bin:/opt/devkitpro/devkitARM/bin:${PATH}
RUN for tool in arm-none-eabi-g++ armips flips bannertool makerom 3gxtool; do command -v "$tool" || exit 1; done

COPY docker-build.sh /usr/local/bin/cirrus-build
RUN sed -i 's/\r$//' /usr/local/bin/cirrus-build && chmod +x /usr/local/bin/cirrus-build
WORKDIR /src
ENTRYPOINT ["/usr/local/bin/cirrus-build"]
