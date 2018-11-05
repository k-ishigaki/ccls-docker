FROM ubuntu
MAINTAINER k-ishigaki <k-ishigaki@frontier.hokudai.ac.jp>

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libncurses-dev \
    zlib1g-dev \
    && apt-get clean

RUN git clone --depth=1 --recursive https://github.com/MaskRay/ccls \
    && cd ccls \
    && cmake -H. -BRelease \
    && cmake --build Release

ENV PATH $PATH:/ccls/Release
