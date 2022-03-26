# SimpleTorRelay

Preconfigured tor middle relay.  

## Ports

Exposed ports wich should be forwarded in the firewall.  

* 9001 : ORPort
* 9030 : DirPort

## Data

All data is stored in `/app/data`.
This path is a volume which should be persisted to maintain the relay identity.

## Environment

All environment variables are optional and set the according options.  

* TOR_NICKNAME : Nickname
* TOR_CONTACTINFO : ContactInfo
* TOR_ADDRESS : Address
* TOR_RELAYBANDWIDTHRATE : RelayBandwidthRate
* TOR_RELAYBANDWIDTHBURST : RelayBandwidthBurst
