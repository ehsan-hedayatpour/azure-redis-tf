locals {
  redis_cache_family = var.sku_name == "Basic" || var.sku_name == "Standard" ? "C" : "P"
}