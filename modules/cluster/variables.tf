variable "cluster_id" {
  description = "Unique identifier for the cluster"
  type        = string
  default     = "microk8s"
}

variable "cluster_version" {
  description = "Version of Kubernetes to install"
  type        = string
  default     = "v1.21.0"
}

variable "domain" {
  description = "Domain name for the cluster"
  type        = string
  default     = "appkins.net"
}

variable "onepassword" {
  description = "1Password connection details"
  type = object({
    credentials = optional(any, null)
    token       = optional(string, null)
  })
  default = null
}

variable "organization" {
  description = "Organization name for the cluster"
  type        = string
  default     = "appkins"
}

variable "pod_subnet" {
  description = "Pod subnet for the cluster"
  type        = string
  default     = "10.244.0.0/24"
}

variable "private_ip" {
  description = "Private IP address for the cluster"
  type        = string
  default     = ""
}

variable "public_ip" {
  description = "Public IP address for the cluster"
  type        = string
  default     = ""
}

variable "ssh" {
  description = "SSH connection details"
  type = object({
    user        = optional(string, null)
    password    = optional(string, null)
    host        = optional(string, null)
    private_key = optional(string, null)
  })
}
