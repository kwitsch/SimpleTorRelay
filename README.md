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

## Example Stack 

Example stack to deploy a tor relay in a swarm to a node with the label tor=true.

```YAML
version: "3.8"

services:
  relay:
    image: ghcr.io/kwitsch/simpletorrelay
    deploy:
      placement:
        constraints: 
          - node.labels.tor == true
    volumes:
      - /etc/localtime:/etc/localtime:ro #sync time with host
      - /tordata:/app/data #store data on disk
    environment:
      - TOR_NICKNAME=ExampleRelay
      - TOR_CONTACTINFO=your@mail.address
    ports: #expose ports in host mode to reduce load on ingress network
      - target: 9001
        published: 9001
        protocol: tcp
        mode: host
      - target: 9030
        published: 9030
        protocol: tcp
        mode: host
```