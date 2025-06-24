module "redis_cache" {
  source                        = "./modules/redis"
  capacity                      = var.capacity
  name                          = var.redis_cache_name
  redis_version                 = var.redis_version
  resource_group_name           = var.resource_group_name
  non_ssl_port_enabled          = var.non_ssl_port_enabled
  sku_name                      = var.sku_name
  minimum_tls_version           = var.minimum_tls_version
  location                      = var.location
  public_network_access_enabled = var.public_network_access_enabled

  redis_configuration = {
    maxmemory_reserved                      = 299
    maxmemory_delta                         = 299
    maxmemory_policy                        = "volatile-ttl"
    rdb_backup_enabled                      = false
    active_directory_authentication_enabled = false
  }
}
