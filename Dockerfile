FROM ghcr.io/kwitsch/alpinetor AS compose

WORKDIR /app

COPY src/entrypoint.sh entrypoint.sh
COPY src/torrc torrc

RUN chmod +x entrypoint.sh
RUN chmod +w torrc
RUN mkdir data
RUN cp /usr/local/bin/tor tor
RUN cp /geoip geoip

FROM alpine

COPY --from=compose /app /app

WORKDIR /app

RUN apk update && \
    apk add --no-cache \
    ca-certificates \
    tzdata && \
    adduser -S -D -H -s /sbin/nologin tor && \
    chown -R tor /app

VOLUME ["/app/data"]

EXPOSE 9001

USER tor

ENTRYPOINT [ "/bin/sh" ]
CMD [ "/app/entrypoint.sh" ]