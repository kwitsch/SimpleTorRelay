FROM alpine

RUN apk add --no-cache \
        tor \
        python2 \
        tzdata  \
        libevent \
        libressl \
        xz-libs \
        zstd-libs \
        zlib \
        zstd \
        pwgen

COPY src/torrc /etc/tor/torrc
COPY src/entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh && \
    chown -R tor /etc/tor 

VOLUME ["/var/lib/tor"]

ENV TOR_NICKNAME=SimpleRelay
ENV TOR_CONTACTINFO=simple@relay.tor

EXPOSE 9001

USER tor

ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]