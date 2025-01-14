module "base" {
  source           = "../../modules/runyutesttemplate"
  location         = "eastus"
  site_id          = basename(abspath(path.module))
  domain_fqdn      = "jumpstart.local"
  starting_address = "192.168.1.55"
  ending_address   = "192.168.1.65"
  default_gateway  = "192.168.1.1"
  dns_servers      = ["192.168.1.254"]
  adou_suffix      = "DC=jumpstart,DC=local"
  dc_ip            = "192.168.1.100"
  servers = [
    {
      name         = "HOST1",
      ipv4Address = "192.168.1.12"
    },
    {
      name        = "HOST2",
      ipv4Address = "192.168.1.13"
    }
  ]
  management_adapters = ["FABRIC", "FABRIC2"]
  storage_networks = [
    {
      name               = "Storage1Network",
      networkAdapterName = "StorageA",
      vlanId             = "711"
    },
    {
      name               = "Storage2Network",
      networkAdapterName = "StorageB",
      vlanId             = "712"
    }
  ]
  rdma_enabled                    = false     // Change to true if RDMA is enabled.
  storage_connectivity_switchless = false     // Change to true if storage connectivity is switchless.
  enable_provisioners             = true      // Change to false when Arc servers are connected by yourself.
  authentication_method           = "Credssp" // or "Default"
  subscription_id                 = var.subscription_id
  domain_admin_user               = var.domain_admin_user
  domain_admin_password           = var.domain_admin_password
  local_admin_user                = var.local_admin_user
  local_admin_password            = var.local_admin_password
  deployment_user_password        = var.deployment_user_password
  service_principal_id            = var.service_principal_id
  service_principal_secret        = var.service_principal_secret
  rp_service_principal_object_id  = var.rp_service_principal_object_id

  # Region HCI logical network parameters
  lnet_starting_address = "192.168.1.171"
  lnet_ending_address   = "192.168.1.190"   # This IP range should not overlap with HCI infra IP range.
  lnet_address_prefix   = "192.168.1.0/24"  # E.g., 192.168.1.0/24
  lnet_default_gateway  = "192.168.1.1"     # Default gateway can be same as HCI infra default gateway.
  lnet_dns_servers      = ["192.168.1.254"] # DNS servers can be same as HCI infra DNS servers.

  # Region AKS Arc parameters
  aks_arc_control_plane_ip    = "192.168.1.190"      # An IP address in the logical network IP range.
  rbac_admin_group_object_ids = ["11111111-6655-4844-9922-030049995000"] # An AAD group that will have the admin permission of this AKS Arc cluster. Check ./doc/AKS-Arc-Admin-Groups.md for details

  # Region HCI VM parameters
  # Uncomment this section will create a windows server VM on HCI.
  # download_win_server_image = true
  # vm_admin_password         = var.vm_admin_password
  # domain_join_password      = var.domain_join_password

  # Region site manager parameters
  # Uncomment this section will create site manager instance for the resource group.
  # Check ./doc/Add-Site-Manager.md for more information
  # country = "<country>"
}
