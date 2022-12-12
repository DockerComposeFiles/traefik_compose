# Docker Deamon

nano /etc/default/docker


nano /etc/docker/daemon.json

{
  "debug": true,
  "tls": true,
  "tlscert": "/var/docker/server.pem",
  "tlskey": "/var/docker/serverkey.pem",
  "hosts": ["tcp://159.69.47.58:5555"]
}