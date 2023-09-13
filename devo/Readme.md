# Genral Traefik

(secure).entrypoints        Traefik-Name
(secure).rule=Host          Domain
secure.tls.certresolver     Zertifizierungsservice

middlewares=secHeaders@file Sicherheitseinstellungen

## http->https middleware
- traefik.http.middlewares.container-https-redirect.redirectscheme.scheme=https
- traefik.http.routers.container.middlewares=container-https-redirect
