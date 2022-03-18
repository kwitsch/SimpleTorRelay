#!/bin/sh -e

printf "\nNickname ${TOR_NICKNAME}" >> /torrc
printf "\nContactInfo ${TOR_CONTACTINFO}" >> /torrc

exec tor -f /torrc