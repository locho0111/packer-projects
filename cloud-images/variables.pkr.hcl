variable "ami_prefix" {
  type    = string
  default = "my-ubuntu"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_regions" {
  type    = list(string)
  default = ["us-west-2"]
}

variable "tags" {
  type = map(string)
  default = {
    "Name"        = "MyUbuntuImage"
    "Environment" = "Production"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure tentant ID"
}

variable "azure_client_id" {
  type        = string
  description = "Azure client ID"
}

variable "azure_client_secret" {
  type        = string
  description = "Azure client secret"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}