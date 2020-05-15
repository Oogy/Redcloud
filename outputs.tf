output "portainer_admin_password" {
  sensitive = true
  value     = bcrypt(random_password.portainer_admin_password.result)
}

output "traefik_admin_password" {
  sensitive = true
  value     = bcrypt(random_password.traefik_admin_password.result)
}
