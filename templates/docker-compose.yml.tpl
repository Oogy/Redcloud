version: "3"

services:
  traefik:
    image: "traefik:v2.2"
    container_name: "traefik"
    networks:
      - private
    command:
      - "--log.level=DEBUG"
      - "--accesslog=true"
      - "--providers.docker=true"
      - "--entrypoints.frontend.address=:80"
      - "--entrypoints.frontendsecure.address=:443"
      - "--entrypoints.frontend.http.redirections.entryPoint.to=frontendsecure"
      - "--entrypoints.frontend.http.redirections.entryPoint.scheme=https"
    ports:
      - 80:80
      - 443:443
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  portainer:
    image: portainer/portainer
    container_name: "redcloud-portainer"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /tmp/portainer/data:/data
    command:  --host=unix:///var/run/docker.sock --logo "${ TF_PORTAINER_LOGO_URL }" --templates "http://templates/templates.yml" --admin-password='${ TF_PORTAINER_ADMIN_PASS }'
    networks:
      - private
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=redcloud_private"
      - "traefik.http.routers.whoami.rule=Host(`redcloud.${ TF_REDCLOUD_DOMAIN }`)"
      - "traefik.http.routers.whoami.entrypoints=frontendsecure"
      - "traefik.http.routers.whoami.tls=true"
      - "traefik.http.routers.whoami.service=portainer-redcloud"

networks:
  private:
    external: false
