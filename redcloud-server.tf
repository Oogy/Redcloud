data "vultr_region" "region" {
  filter {
    name   = "name"
    values = [var.region]
  }
}

data "vultr_plan" "server_plan" {
  filter {
    name   = "name"
    values = [var.server_plan]
  }
}

data "vultr_application" "application" {
  filter {
    name   = "deploy_name"
    values = [var.application]
  }
}

resource "vultr_ssh_key" "local" {
  name    = "provisioner"
  ssh_key = trimspace(file("~/.ssh/id_rsa.pub"))
}

resource "vultr_ssh_key" "extra" {
  count   = length(var.extra_ssh_keys)
  name    = "provisioner"
  ssh_key = var.extra_ssh_keys[count.index]
}

resource "vultr_server" "server" {
  count       = var.server_count
  region_id   = data.vultr_region.region.id
  plan_id     = data.vultr_plan.server_plan.id
  app_id      = data.vultr_application.application.id
  hostname    = "${var.redcloud_server_hostname_prefix}-${count.index}"
  label       = "${var.redcloud_server_hostname_prefix}-${count.index}"
  ssh_key_ids = vultr_ssh_key.local.id

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.main_ip
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://github.com/docker/compose/releases/download/${var.compose_release}/docker-compose-Linux-x86_64",
      "mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose",
      "chmod +x /usr/local/bin/docker-compose",
    ]
  }
}
