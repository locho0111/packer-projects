packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

build {
  name        = "ubuntu"
  description = <<EOF
This build creates ubuntu images for ubuntu versions :
* 20.04
* 22.04
For the following builers :
* amazon-ebs
* azure-arm
EOF
  sources = [
    "source.amazon-ebs.ubuntu_20",
    "source.amazon-ebs.ubuntu_22",
    "source.azure-arm.ubuntu_20",
    "source.azure-arm.ubuntu_22",
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx"
    ]
  }

  provisioner "shell" {
    only   = ["source.amazon-ebs.ubuntu*"]
    inline = ["sudo apt-get install awscli"]
  }

  provisioner "shell" {
    only   = ["source.azure-arm.ubuntu*"]
    inline = ["sudo apt-get install azure-cli"]
  }

  post-processor "manifest" {}

}