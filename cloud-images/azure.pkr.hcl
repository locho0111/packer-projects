source "azure-arm" "ubuntu_20" {
  subscription_id                   = var.azure_subscription_id
  tenant_id                         = var.azure_tenant_id
  client_id                         = var.azure_client_id
  client_secret                     = var.azure_client_secret
  managed_image_resource_group_name = "packer_images"
  managed_image_name                = "packer-ubuntu-azure-${local.timestamp}"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-focal"
  image_sku       = "20_04-lts"

  azure_tags = {
    Created-by = "Packer"
    OS_Version = "Ubuntu 20.04"
    Release    = "Latest"
  }

  location = "East US"
  vm_size  = "Standard_D2s_v3"
}

source "azure-arm" "ubuntu_22" {
  subscription_id                   = var.azure_subscription_id
  tenant_id                         = var.azure_tenant_id
  client_id                         = var.azure_client_id
  client_secret                     = var.azure_client_secret
  managed_image_resource_group_name = "packer_images"
  managed_image_name                = "packer-ubuntu-azure-${local.timestamp}"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"

  azure_tags = {
    Created-by = "Packer"
    OS_Version = "Ubuntu 22.04"
    Release    = "Latest"
  }

  location = "East US"
  vm_size  = "Standard_D2s_v3"
}

source "azure-arm" "windows_2019" {
  subscription_id                   = var.azure_subscription_id
  tenant_id                         = var.azure_tenant_id
  client_id                         = var.azure_client_id
  client_secret                     = var.azure_client_secret
  managed_image_resource_group_name = "packer_images"
  managed_image_name                = "packer-w2k19-azure-${local.timestamp}"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2019-Datacenter"

  communicator     = "winrm"
  winrm_use_ssl    = true
  winrm_insecure   = true
  winrm_timeout    = "5m"
  winrm_username   = "packer"
  custom_data_file = "./scripts/SetUpWinRM.ps1"

  azure_tags = {
    Created-by = "Packer"
    OS_Version = "Windows 2019"
    Release    = "Latest"
  }

  location = "East US"
  vm_size  = "Standard_D2s_v3"
}

source "azure-arm" "windows_2022" {
  subscription_id                   = var.azure_subscription_id
  tenant_id                         = var.azure_tenant_id
  client_id                         = var.azure_client_id
  client_secret                     = var.azure_client_secret
  managed_image_resource_group_name = "packer_images"
  managed_image_name                = "packer-w2k22-azure-${local.timestamp}"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2022-Datacenter"

  communicator     = "winrm"
  winrm_use_ssl    = true
  winrm_insecure   = true
  winrm_timeout    = "5m"
  winrm_username   = "packer"
  custom_data_file = "./scripts/SetUpWinRM.ps1"

  azure_tags = {
    Created-by = "Packer"
    OS_Version = "Windows 2022"
    Release    = "Latest"
  }

  location = "East US"
  vm_size  = "Standard_D2s_v3"
}