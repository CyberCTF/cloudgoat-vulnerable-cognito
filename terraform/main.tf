# Wrapper root module (this lab's own file, not upstream's): applies CloudGoat's
# vulnerable_cognito scenario (app/cloudgoat/scenarios/aws/vulnerable_cognito/terraform,
# unchanged) as a child module with the variables CloudGoat's Python CLI would pass: a cgid
# ("vulnerable_cognito_cgid" and ten random characters, as CloudGoat makes it), the AWS profile
# and a cg_whitelist (required by the scenario's variables but unused by its resources). The
# scenario reads files relative to Terraform's working directory: this lab's `assets` is a symlink
# to the scenario's own.
terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  description = "The AWS CLI profile the scenario's provider (and its deploy steps) use."
  type        = string
  default     = "default"
}

resource "random_string" "cgid" {
  length  = 10
  upper   = false
  special = false
}

module "scenario" {
  source       = "./scenario"
  profile      = var.profile
  region       = var.region
  cgid         = "vulnerable_cognito_cgid${random_string.cgid.result}"
  cg_whitelist = ["0.0.0.0/0"]
}

output "account_id" {
  value = module.scenario.cloudgoat_output_aws_account_id
}

output "apigateway_url" {
  value = module.scenario.apigateway_url
}
