build {
  name        = "windows"
  description = <<EOF
This build creates Windows images:
* Windows 2019
* Windows 2022
For the following builers :
* amazon-ebs
* azure-arm
EOF
  sources = [
    "source.amazon-ebs.windows_2019",
    "source.amazon-ebs.windows_2022",
    "source.azure-arm.windows_2019",
    "source.azure-arm.windows_2022"
  ]

  post-processor "manifest" {
  }
}