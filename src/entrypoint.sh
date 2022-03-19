#!/bin/sh -e

if [ ! -z "$TOR_NICKNAME" ]; then
    printf "\nNickname ${TOR_NICKNAME}" >> /torrc
fi

if [ ! -z "$TOR_CONTACTINFO" ]; then
    printf "\nContactInfo ${TOR_CONTACTINFO}" >> /torrc
fi

if [ ! -z "$TOR_ADDRESS" ]; then
    printf "\nAddress ${TOR_ADDRESS}" >> /torrc
fi

if [ ! -z "$TOR_RELAYBANDWIDTHRATE" ]; then
    printf "\nRelayBandwidthRate ${TOR_RELAYBANDWIDTHRATE}" >> /torrc
fi

if [ ! -z "$TOR_RELAYBANDWIDTHBURST" ]; then
    printf "\nRelayBandwidthBurst ${TOR_RELAYBANDWIDTHBURST}" >> /torrc
fi

exec tor -f /torrc