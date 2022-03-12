FROM alpine:3.12.4

RUN apk update && \
    apk add --no-cache \
        tor \
        tzdata

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