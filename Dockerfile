FROM resin/armv7hf-debian-qemu:latest
MAINTAINER Sebastian Schneider <mail@sesc.eu>

RUN [ "cross-build-start" ]

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*

ENV snapcast_version 0.10.0
RUN  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapclient_${snapcast_version}_armhf.deb \
    && dpkg -i snapclient_${snapcast_version}_armhf.deb \
    ; apt-get update \
    && apt-get -f install -y \
    && rm -rf /var/lib/apt/lists/*

RUN [ "cross-build-end" ]

ENTRYPOINT ["snapclient"]
CMD ["-h", "snapserver"]
