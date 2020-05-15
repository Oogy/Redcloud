variable "compose_release" {
  type    = string
  default = "1.25.5"
}

variable "redcloud_domain" {
  type    = string
  default = null
}

variable "redcloud_domain_exists" {
  type    = bool
  default = false
}

variable "redcloud_server_hostname_prefix" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = "New Jersey"
}

variable "server_count" {
  type    = number
  default = 1
}

variable "server_plan" {
  type    = string
  default = "2048 MB RAM,55 GB SSD,2.00 TB BW"
}

variable "application" {
  type    = string
  default = "Docker on Ubuntu 18.04 x64"
}

variable "extra_ssh_keys" {
  type    = list(string)
  default = []
}

variable "portainer_logo_url" {
  type = string
  default = null
}
