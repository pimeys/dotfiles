ARG FEDORA_VERSION=40
FROM fedora:${FEDORA_VERSION}

ARG ROON_BRIDGE_URL=https://download.roonlabs.com/builds/RoonBridge_linuxx64.tar.bz2
ARG ROON_UID=1000
ARG ROON_GID=1000
ARG ROON_USER=roon

ENV ROON_DATAROOT=/var/roon \
    ROON_ID_DIR=/var/roon

RUN dnf -y upgrade --refresh \
    && dnf -y install --setopt=install_weak_deps=False \
        alsa-lib \
        ca-certificates \
        curl \
        glibc-langpack-en \
        shadow-utils \
        tar \
        xz \
    && dnf clean all \
    && rm -rf /var/cache/dnf

RUN groupadd -g ${ROON_GID} ${ROON_USER} \
    && useradd -m -u ${ROON_UID} -g ${ROON_GID} ${ROON_USER}

WORKDIR /opt/roon

RUN curl -fsSL ${ROON_BRIDGE_URL} -o roonbridge.tar.bz2 \
    && tar -xjf roonbridge.tar.bz2 \
    && rm roonbridge.tar.bz2 \
    && chown -R ${ROON_USER}:${ROON_GID} /opt/roon

VOLUME ["/var/roon"]

USER ${ROON_USER}

ENTRYPOINT ["/opt/roon/RoonBridge/start.sh"]
