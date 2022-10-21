# variable "ibmcloud_api_key" {
#   type        = string
#   description = "IBM Cloud API Key"
# }

variable "region" {
  type        = string
  description = "IBM Cloud Region where the VPC will be created"
  default     = "us-south"
}

variable "existing_resource_group" {
  type        = string
  description = "Name of an existing Resource Group for deployment. If not specified, a new Resource Group will be created."
  default     = ""
}

variable "existing_ssh_key" {
  type        = string
  description = "Name of an existing SSH Key for deployment. If not specified, a new SSH Key will be created."
  default     = ""
}



variable "classic_access" {
  description = "Classic Access to the VPC"
  type        = bool
  default     = false
}

variable "default_address_prefix" {
  description = "Default address prefix creation method"
  type        = string
  default     = "auto"
}