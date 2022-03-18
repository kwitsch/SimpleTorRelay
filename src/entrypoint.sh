#!/bin/sh -e

printf "\nNickname ${TOR_NICKNAME}" >> /etc/tor/torrc
printf "\nContactInfo ${TOR_CONTACTINFO}" >> /etc/tor/torrc

exec tor -f /torrc