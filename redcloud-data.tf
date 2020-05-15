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
