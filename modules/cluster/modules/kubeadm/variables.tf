variable "network_plugin" {
  description = "Network plugin to use"
  type        = string
  default     = "cilium"

  validation {
    condition     = contains(["cilium", "calico"], var.network_plugin)
    error_message = "Network plugin must be one of: cilium, calico"
  }
}

variable "pod_subnet" {
  description = "Pod subnet for the cluster"
  type        = string
  default     = "10.217.0.0/16"
}

variable "cluster_id" {
  description = "Unique identifier for the cluster"
  type        = string
  default     = "kubernetes"
}

variable "cluster_version" {
  description = "Version of Kubernetes to install"
  type        = string
  default     = "v1.26.0"
}

variable "organization" {
  description = "Organization name for the cluster"
  type        = string
  default     = "appkins"
}

variable "domain" {
  description = "Domain name for the cluster"
  type        = string
  default     = "appkins.net"
}

variable "public_ip" {
  description = "Public IP address for the cluster"
  type        = string
  default     = ""
}

variable "private_ip" {
  description = "Private IP address for the cluster"
  type        = string
  default     = ""
}

variable "ssh" {
  description = "SSH connection details"
  type = object({
    user     = optional(string, "terraform")
    password = optional(string, null)
    host     = optional(string, null)
  })
  default = {}
}
