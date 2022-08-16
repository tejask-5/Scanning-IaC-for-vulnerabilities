deploy_region = "westeurope"
resource_group_name = "demo3-shared-rg"
environment_name = "local"

sshAccess = "Deny" # Allow or Deny

app_vm_size = "Standard_DS2_v2"
app_admin_user = "adminuser"
# app_admin_password = local env variable

# cloudflare_api_token = local env variable
# cloudflare_service_key = local env variable
# cloudflare_zone_id = local env variable
edge_hostname = "demo.dahdah.xyz"
edge_dns_record = "demo"
