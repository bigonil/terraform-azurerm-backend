variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create"
}

variable "storage_account_prefix" {
  type        = string
  description = "Prefix for the storage account (must be globally unique)"
}

variable "container_name" {
  type        = string
  description = "Name of the container to store the state in"
  default     = "tfstate"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}
variable "artifacts_container_name" {
  type        = string
  description = "Name of the container to store artifacts in"
  default     = "artifacts"
}