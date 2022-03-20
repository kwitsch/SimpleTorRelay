#!/bin/sh -e

if [ ! -z "$TOR_NICKNAME" ]; then
    printf "\nNickname ${TOR_NICKNAME}" >> /torrc
fi

if [ ! -z "$TOR_CONTACTINFO" ]; then
    printf "\nContactInfo ${TOR_CONTACTINFO}" >> /torrc
fi

if [ ! -z "$TOR_RELAYBANDWIDTHRATE" ]; then
    printf "\nRelayBandwidthRate ${TOR_RELAYBANDWIDTHRATE}" >> /torrc
fi

if [ ! -z "$TOR_RELAYBANDWIDTHBURST" ]; then
    printf "\nRelayBandwidthBurst ${TOR_RELAYBANDWIDTHBURST}" >> /torrc
fi

if [ ! -z "$TOR_ADDRESS" ]; then
    printf "\nORPort ${TOR_ADDRESS}:9001 IPv4Only" >> /torrc
    printf "\nDirPort ${TOR_ADDRESS}:9030 IPv4Only" >> /torrc
else
    printf "\nORPort 9001 IPv4Only" >> /torrc
    printf "\nDirPort 9030 IPv4Only" >> /torrc
fi

printf "\n" >> /torrc

exec tor -f /torrc