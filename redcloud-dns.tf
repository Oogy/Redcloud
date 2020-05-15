resource "vultr_dns_domain" "redcloud_domain" {
  count     = var.redcloud_domain_exists ? 0 : 1
  domain    = var.redcloud_domain
  server_ip = vultr_server.server[0].main_ip
}

data "vultr_dns_domain" "redcloud_domain" {
  count  = var.redcloud_domain_exists ? 1 : 0
  domain = var.redcloud_domain
}

resource "vultr_dns_record" "my_record" {
  domain = var.redcloud_domain_exists ? data.vultr_dns_domain.redcloud_domain.id : vultr_dns_domain.redcloud_domain.id
  name   = "redcloud"
  data   = vultr_server.server[0].main_ip
  type   = "A"
}


