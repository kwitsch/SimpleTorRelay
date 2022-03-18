FROM alpine AS build

ENV TOR_VERSION 0.4.6.9
ENV TOR_TARBALL_NAME tor-$TOR_VERSION.tar.gz
ENV TOR_TARBALL_LINK https://dist.torproject.org/$TOR_TARBALL_NAME
ENV TOR_TARBALL_ASC $TOR_TARBALL_NAME.asc

RUN apk update
RUN apk add --no-cache \
    make \
    automake \
    autoconf \
    gcc \
    libtool \
    curl \
    libevent-dev \
    musl \
    musl-dev \
    libgcc \
    openssl \
    openssl-dev \
    openssh \
    gnupg \
    zlib-dev

RUN wget $TOR_TARBALL_LINK
RUN wget $TOR_TARBALL_LINK.asc
RUN gpg --keyserver keys.openpgp.org --recv-keys 7A02B3521DC75C542BA015456AFEE6D49E92B601
RUN gpg --verify $TOR_TARBALL_NAME.asc
RUN tar xvf $TOR_TARBALL_NAME

WORKDIR /tor-$TOR_VERSION

RUN ./configure
RUN make
RUN make install

FROM alpine AS compose

COPY --from=build /usr/local/bin /usr/local/bin

RUN apk update && \
    apk add --no-cache \
    musl \
    openssl \
    libevent \
    tzdata
    
RUN adduser -S -D -H -s /sbin/nologin tor
COPY src/entrypoint.sh entrypoint.sh
COPY src/torrc /torrc
RUN chmod +x entrypoint.sh
RUN chown tor /torrc
RUN chmod +w /torrc

RUN mkdir /tordata
RUN chown -R tor /tordata

FROM scratch 

COPY --from=compose / /

VOLUME ["/tordata"]

ENV TOR_NICKNAME=SimpleRelay
ENV TOR_CONTACTINFO=simple@relay.tor

EXPOSE 9001 9030

USER tor

ENTRYPOINT [ "/bin/sh" ]
CMD [ "entrypoint.sh" ]