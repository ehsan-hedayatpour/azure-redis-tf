variable "redis_cache_name" {
  type        = string
  description = "The name of the resource."
  default     = "redis"
  validation {
    condition     = can(regex("^[-A-Za-z0-9]{1,63}$", var.redis_cache_name))
    error_message = "The name must be between 1 and 63 characters long and can only contain alphanumerics and hyphens."
  }
}

variable "capacity" {
  type    = number
  default = 2
}

variable "redis_version" {
  type    = string
  default = "6"
}

variable "sku_name" {
  type        = string
  default     = "Standard"
  description = "The Redis SKU to use. Possible values are `Basic`, `Standard`, and `Premium`. Note: Downgrading the sku will force new resource creation!"
}

variable "resource_group_name" {
  type    = string
  default = "redis-rg"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "minimum_tls_version" {
  type    = string
  default = "1.2"
}

variable "non_ssl_port_enabled" {
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}