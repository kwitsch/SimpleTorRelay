#!/bin/sh -e

if [[ -v TOR_NICKNAME ]]; then
    printf "\nNickname ${TOR_NICKNAME}" >> /torrc
fi

if [[ -v TOR_CONTACTINFO ]]; then
    printf "\nContactInfo ${TOR_CONTACTINFO}" >> /torrc
fi

if [[ -v TOR_ADDRESS ]]; then
    printf "\nAddress ${TOR_ADDRESS}" >> /torrc
fi

if [[ -v TOR_RELAYBANDWIDTHRATE ]]; then
    printf "\nRelayBandwidthRate ${TOR_RELAYBANDWIDTHRATE}" >> /torrc
fi

if [[ -v TOR_RELAYBANDWIDTHBURST ]]; then
    printf "\nRelayBandwidthBurst ${TOR_RELAYBANDWIDTHBURST}" >> /torrc
fi

exec tor -f /torrc