packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

variable "ami_prefix" {
  type = string
  # default = "my-ubuntu"
}

variable "region" {
  type = string
  # default = "us-east-1"
}

variable "instance_type" {
  type = string
  # default = "t2.micro"
}

variable "ami_regions" {
  type = list(string)
  # default = ["us-east-1"]
}

variable "tags" {
  type = map(string)
  default = {
    "Name"       = "MyUbuntuImage"
    "Enviroment" = "Production"
    "OS_Version" = "Ubuntu 22.04"
    "Release"    = "Lastest"
    "Created-by" = "Packer"
  }
}

source "amazon-ebs" "ubuntu" {
  # ami_name              = "${var.ami_prefix}-${local.timestamp}"
  ami_name              = "${var.ami_prefix}"
  instance_type         = var.instance_type
  region                = var.region
  ami_regions           = var.ami_regions
  force_delete_snapshot = true
  force_deregister      = true
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags         = var.tags
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
    ]
  }

  provisioner "file" {
    source      = "assets/"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }
}