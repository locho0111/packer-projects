data "amazon-ami" "windows_2019" {
  filters = {
    name = "Windows_Server-2019-English-Full-Base-*"
  }
  most_recent = true
  owners      = ["801119661308"]
  region      = "us-east-1"
}

data "amazon-ami" "windows_2022" {
  filters = {
    name = "Windows_Server-2022-English-Full-Base-*"
  }
  most_recent = true
  owners      = ["801119661308"]
  region      = "us-east-1"
}

source "amazon-ebs" "ubuntu_20" {
  ami_name      = "${var.ami_prefix}-ubuntu-20-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.region
  ami_regions   = var.ami_regions
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags         = var.tags
}

source "amazon-ebs" "ubuntu_22" {
  ami_name      = "${var.ami_prefix}-ubuntu-22-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.region
  ami_regions   = var.ami_regions
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


source "amazon-ebs" "amazon_linux" {
  ami_name      = "packer-aws-linux-aws-{{timestamp}}"
  instance_type = "t3.micro"
  region        = "us-west-2"
  ami_regions   = ["us-west-2"]
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm*"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
  tags = {
    "Name"        = "MyAmazonLinuxImage"
    "Environment" = "Production"
    "OS_Version"  = "Amazon 2"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}

source "amazon-ebs" "windows_2019" {
  ami_name       = "my-windows-2019-aws-{{timestamp}}"
  communicator   = "winrm"
  instance_type  = "t3.micro"
  region         = "us-east-1"
  source_ami     = "${data.amazon-ami.windows_2019.id}"
  user_data_file = "./scripts/SetUpWinRM.ps1"
  winrm_insecure = true
  winrm_use_ssl  = true
  winrm_username = "Administrator"
  tags = {
    "Name"        = "MyWindowsImage"
    "Environment" = "Production"
    "OS_Version"  = "Windows"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}

source "amazon-ebs" "windows_2022" {
  ami_name       = "my-windows-2022-aws-{{timestamp}}"
  communicator   = "winrm"
  instance_type  = "t3.micro"
  region         = "us-east-1"
  source_ami     = "${data.amazon-ami.windows_2022.id}"
  user_data_file = "./scripts/SetUpWinRM.ps1"
  winrm_insecure = true
  winrm_use_ssl  = true
  winrm_username = "Administrator"
}