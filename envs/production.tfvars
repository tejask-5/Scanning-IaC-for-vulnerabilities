deploy_region = "westeurope"
resource_group_name = "demo3-shared-rg"
environment_name = "production"

sshAccess = "Deny" # Allow or Deny

app_vm_size = "Standard_DS2_v2"
app_admin_user = "adminuser"
# app_admin_password = local env variable