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


    command:
      - '--log.level=DEBUG'
      - '--log.format=json'
      - '--experimental.hub=true'
      - '--hub.tls.insecure'
      - '--metrics.prometheus.addrouterslabels=true'
      - '--global.checkNewVersion=true'
      - '--global.sendAnonymousUsage=false'
      - '--entryPoints.web.address=:80'
      - '--entryPoints.web-secure.address=:443'
      - '--api'
      - '--api.debug'
      - '--api.insecure=true'
      - '--api.dashboard=true'
      - '--ping'
      - '--providers.docker.exposedByDefault=false'
      - '--providers.docker.watch=true'
      - '--providers.file.watch=true'
      - '--providers.file.filename=/rules.yml'
      - '--certificatesresolvers.basic.acme.tlschallenge=true'
      - '--certificatesresolvers.basic.acme.email=${EMAIL}'
      - '--certificatesresolvers.basic.acme.storage=/letsencrypt/acme.json'
      - '--serversTransport.insecureSkipVerify=true'

    volumes:
      - '/var/run/docker.sock:/var/run/docker.sock'
      - 'letsencrypt:/letsencrypt'
      - './traefik_v2/rules.yml:/rules.yml'