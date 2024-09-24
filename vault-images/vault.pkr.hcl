variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vault_zip" {
  type        = string
  description = "path to vault zip file"
  default = ""
}

variable "dry-run" {
  type    = bool
  default = true
}

locals {
  vault_zip = "${path.cwd}/zip-file/vault_1.17.5_linux_amd64.zip"
}

data "amazon-ami" "amazon-linux-2" {
  filters = {
    name                = "amzn2-ami-hvm-2.*-x86_64-gp2"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = var.aws_region
}

source "amazon-ebs" "amazon-ebs-amazonlinux-2" {
  skip_create_ami             = var.dry-run
  ami_description             = "Vault - Amazon Linux 2"
  ami_name                    = "vault-amazonlinux2"
  ami_regions                 = ["us-east-1"]
  ami_virtualization_type     = "hvm"
  associate_public_ip_address = true
  force_delete_snapshot       = true
  force_deregister            = true
  instance_type               = "t2.micro"
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.amazon-linux-2.id
  ssh_username                = "ec2-user"
  tags = {
    Name = "HashiCorp Vault"
    OS   = "Amazon Linux 2"
  }
}

build {
  sources = ["source.amazon-ebs.amazon-ebs-amazonlinux-2"]

  provisioner "file" {
    destination = "/tmp/vault.zip"
    source      = var.vault_zip
  }

  provisioner "file" {
    destination = "/tmp"
    source      = "config-file/"
  }
}

