variable "name" {
  type        = string
  description = "The name of the this resource."

  validation {
    condition     = can(regex("^[-A-Za-z0-9]{1,63}$", var.name))
    error_message = "The name must be between 1 and 63 characters long and can only contain alphanumerics and hyphens."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "access_keys_authentication_enabled" {
  type        = bool
  default     = null
  description = "(Optional) - Whether access key authentication is enabled? Defaults to `true`. `active_directory_authentication_enabled` must be set to `true` to disable access key authentication."
}

variable "capacity" {
  type        = number
  default     = null
  description = "(Required) - The size of the Redis Cache to deploy.  Valid values for Basic and Standard skus are 0-6, and for the premium sku is 1-5"
}

variable "non_ssl_port_enabled" {
  type        = bool
  default     = null
  description = "(Optional) - Enable the non-ssl port 6379.  Disabled by default"
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) - The minimum TLS version.  Possible values are `1.0`, `1.1`, and `1.2`.  Defaults to `1.2`"
}

variable "patch_schedule" {
  type = set(object({
    day_of_week        = optional(string, "Saturday")
    maintenance_window = optional(string, "PT5H")
    start_hour_utc     = optional(number, 0)
  }))
  default     = []
  description = <<DESCRIPTION
A set of objects describing the following patch schedule attributes. If no value is configured defaults to an empty set.
- `day_of_week` - (Optional) - A string value for the day of week to start the patch schedule.  Valid values are `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, and `Sunday`.
- `maintenance_window` - (Optional) - A string value following the ISO 8601 timespan system which specifies the length of time the Redis Cache can be updated from the start hour. Defaults to `PT5H`.
- `start_hour_utc` - (Optional) - The start hour for maintenance in UTC. Possible values range from 0-23.  Defaults to 0.

Example Input:

```hcl
patch_schedule = [
  {
    day_of_week = "Friday"
    maintenance_window = "PT5H"
    start_hour_utc = 23
  }
]
```
DESCRIPTION
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "(Optional) - Identifies whether the public network access is allowed for the Redis Cache. `True` means that both public and private endpoint access is allowed. `False` limits access to the private endpoint only. Defaults to `True`."
}

variable "redis_configuration" {
  type = object({
    aof_backup_enabled                       = optional(bool)
    aof_storage_connection_string_0          = optional(string)
    aof_storage_connection_string_1          = optional(string)
    active_directory_authentication_enabled  = optional(bool)
    maxmemory_reserved                       = optional(number)
    maxmemory_delta                          = optional(number)
    maxfragmentationmemory_reserved          = optional(number)
    maxmemory_policy                         = optional(string)
    rdb_backup_enabled                       = optional(bool) #TODO: Research if we want backups to be true. Given this is cache, probably not required.
    rdb_backup_frequency                     = optional(number)
    rdb_backup_max_snapshot_count            = optional(number)
    rdb_storage_connection_string            = optional(string)
    storage_account_subscription_resource_id = optional(string)
    notify_keyspace_events                   = optional(string)
  })
  default     = {}
  description = <<DESCRIPTION
Describes redis configuration block.
- `aof_backup_enabled`                       = (Optional) Enable or disable AOF persistence for this Redis Cache. Defaults to false. Note: `aof_backup_enabled` can only be set when SKU is Premium.
- `aof_storage_connection_string_0`          = (Optional) First Storage Account connection string for AOF persistence.
- `aof_storage_connection_string_1`          = (Optional) Second Storage Account connection string for AOF persistence.
- `enable_authentication`                    = (Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true.
- `active_directory_authentication_enabled`  = (Optional) Enable Microsoft Entra (AAD) authentication. Defaults to false.
- `maxmemory_reserved`                       = (Optional) Value in megabytes reserved for non-cache usage e.g. failover. Defaults are shown below.
- `maxmemory_delta`                          = (Optional) The max-memory delta for this Redis instance. Defaults are shown below.
- `maxmemory_policy`                         = (Optional) How Redis will select what to remove when maxmemory is reached. Defaults to volatile-lru.
- `data_persistence_authentication_method`   = (Optional) Preferred auth method to communicate to storage account used for data persistence. Possible values are SAS and ManagedIdentity. Defaults to SAS.
- `maxfragmentationmemory_reserved`          = (Optional) Value in megabytes reserved to accommodate for memory fragmentation. Defaults are shown below.
- `rdb_backup_enabled`                       = (Optional) Is Backup Enabled? Only supported on Premium SKUs. Defaults to false. Note - If rdb_backup_enabled set to true, rdb_storage_connection_string must also be set.
- `rdb_backup_frequency`                     = (Optional) The Backup Frequency in Minutes. Only supported on Premium SKUs. Possible values are: 15, 30, 60, 360, 720 and 1440.
- `rdb_backup_max_snapshot_count`            = (Optional) The maximum number of snapshots to create as a backup. Only supported for Premium SKUs.
- `rdb_storage_connection_string`            = (Optional) The Connection String to the Storage Account. Only supported for Premium SKUs. In the format: DefaultEndpointsProtocol=https;BlobEndpoint=\$\{azurerm_storage_account.example.primary_blob_endpoint\};AccountName=\$\{azurerm_storage_account.example.name\};AccountKey=\$\{azurerm_storage_account.example.primary_access_key\}.
- `storage_account_subscription_resource_id` = (Optional) The ID of the Subscription containing the Storage Account.
- `notify_keyspace_events`                   = (Optional) Keyspace notifications allows clients to subscribe to Pub/Sub channels in order to receive events affecting the Redis data set in some way.

Example Input:

```hcl
redis_configuration = {
  maxmemory_reserved = 10
  maxmemory_delta    = 2
  maxmemory_policy   = "allkeys-lru"
}
```
DESCRIPTION
}

variable "redis_version" {
  type        = number
  default     = null
  description = "(Optional) Redis version.  Only major version needed.  Valid values are: `4` and `6`"
}

variable "sku_name" {
  type        = string
  default     = "Premium"
  description = "(Required) - The Redis SKU to use.  Possible values are `Basic`, `Standard`, and `Premium`. Note: Downgrading the sku will force new resource creation." #TODO validate whether we can merge Open Source and Premium skus
}

variable "location" {}