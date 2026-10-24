output "resource_group" {
  value = azurerm_resource_group.main.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.vm.private_ip_address
}

output "storage_account" {
  value = azurerm_storage_account.main.name
}

output "log_analytics_workspace" {
  value = azurerm_log_analytics_workspace.main.name
}
