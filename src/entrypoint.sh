#!/bin/sh -e

echo "Nickname ${TOR_NICKNAME}" >> /etc/tor/torrc
echo "ContactInfo ${TOR_CONTACTINFO}" >> /etc/tor/torrc

exec tor -f /etc/tor/torrc