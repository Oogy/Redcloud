resource "random_password" "portainer_admin_password" {
  length  = 32
  special = true
}

resource "random_password" "traefik_admin_password" {
  length  = 32
  special = true
}
