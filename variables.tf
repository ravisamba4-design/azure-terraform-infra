variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "location" {
  type    = string
  default = "uksouth"
  validation {
    condition     = contains(["uksouth", "ukwest", "northeurope", "westeurope"], var.location)
    error_message = "Location must be uksouth or ukwest."
  }
}

variable "prefix" {
  type    = string
  default = "tfaz"
  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.prefix))
    error_message = "Prefix must be 2-8 lowercase letters/numbers."
  }
}

variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vnet_cidr))
    error_message = "vnet_cidr must be a valid CIDR."
  }
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "admin_ssh_public_key" {
  type = string
  validation {
    condition     = startswith(var.admin_ssh_public_key, "ssh-")
    error_message = "Provide a valid SSH public key."
  }
}

variable "alert_email" {
  type        = string
  description = "Email for monitoring alerts"
}

variable "zone" {
  type    = string
  default = null
}
