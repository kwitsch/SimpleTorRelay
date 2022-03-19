FROM ghcr.io/kwitsch/alpinetor:0.4.6.9 AS compose

COPY src/entrypoint.sh entrypoint.sh
COPY src/torrc /torrc

RUN chmod +x entrypoint.sh
RUN chmod +w /torrc
RUN mkdir /tordata

FROM alpine

COPY --from=compose /usr/local/bin /usr/local/bin
COPY --from=compose /usr/local/share/tor/geoip /geoip
COPY --from=compose /entrypoint.sh /entrypoint.sh
COPY --from=compose /torrc /torrc
COPY --from=compose /tordata /tordata

RUN apk update && \
    apk add --no-cache \
    musl \
    openssl \
    libevent \
    tzdata \
    curl && \
    adduser -S -D -H -s /sbin/nologin tor && \
    chown tor /geoip && \
    chown tor /torrc && \
    chown -R tor /tordata

VOLUME ["/tordata"]

EXPOSE 9001 9030

USER tor

ENTRYPOINT [ "/bin/sh" ]
CMD [ "entrypoint.sh" ]

HEALTHCHECK --interval=60s --timeout=15s --start-period=90s \
    CMD curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/' | grep -qm1 Congratulations