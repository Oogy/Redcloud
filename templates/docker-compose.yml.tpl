version: "3"

services:
  portainer:
      image: portainer/portainer
      container_name: "portainer-app"
      networks:
        - inside
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - /tmp/portainer/data:/data
      command:  --host=unix:///var/run/docker.sock --logo "${ PORTAINER_LOGO_URL }" --templates "http://templates/templates.yml" --admin-password='${ PORTAINER_ADMIN_PASS }'
