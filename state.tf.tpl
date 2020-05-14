terraform {
  backend "s3" {
    bucket                      = ""
    key                         = "state/redcloud"
    region                      = "us-east-1"
    endpoint                    = "https://ewr1.vultrobjects.com"
    skip_credentials_validation = true
  }
}
