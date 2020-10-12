FROM ubuntu:20.04
LABEL maintainer="Kazuki Ishigaki<k-ishigaki@frontier.hokudai.ac.jp>"

RUN apt-get update && apt-get install -y \
    ccls \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add a normal user
ENV USER_ID 0
ENV GROUP_ID 0
RUN { \
    echo '#!/bin/sh -e'; \
    echo 'chown -f --recursive ${USER_ID}:${GROUP_ID} /root'; \
    echo 'getent group ${GROUP_ID} || addgroup -q --gid ${GROUP_ID} group'; \
    echo 'getent passwd ${USER_ID} || adduser -q --home /root --uid ${USER_ID} --gid ${GROUP_ID} --disabled-login user'; \
    echo '"$@"'; \
    } > /entrypoint && chmod +x /entrypoint
ENTRYPOINT [ "/entrypoint" ]