output "portainer_admin_password" {
  sensitive = true
  value = bcrypt(random_password.portainer_admin_password.result)
}
