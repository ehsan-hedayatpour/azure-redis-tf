output "redis_cache_name" {
  value = azurerm_redis_cache.main.name
}

output "redis_cache_capacity" {
  value = azurerm_redis_cache.main.capacity
}

output "redis_cache_sku_name" {
  value = azurerm_redis_cache.main.sku_name
}

output "redis_cache_non_ssl_port_enabled" {
  value = azurerm_redis_cache.main.non_ssl_port_enabled
}

output "redis_cache_minimum_tls_version" {
  value = azurerm_redis_cache.main.minimum_tls_version
}

output "redis_cache_redis_version" {
  value = azurerm_redis_cache.main.redis_version
}

output "redis_cache_maxmemory_reserved" {
  value = azurerm_redis_cache.main.redis_configuration[0].maxmemory_reserved
}

output "redis_cache_maxmemory_delta" {
  value = azurerm_redis_cache.main.redis_configuration[0].maxmemory_delta
}

output "redis_cache_maxmemory_policy" {
  value = azurerm_redis_cache.main.redis_configuration[0].maxmemory_policy
}
