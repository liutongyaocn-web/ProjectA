variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "docker_host" {
  description = "Remote Docker daemon endpoint"
  type        = string
}

variable "docker_cert_path" {
  description = "TLS certificate path for remote Docker host"
  type        = string
}

variable "app_namespace" {
  type    = string
  default = "my"
}

variable "database_version" {
  type    = string
  default = "v3.1"
}

variable "backend_version" {
  type    = string
  default = "v3"
}

variable "backend_instance_count" {
  type    = number
  default = 3
}

variable "do_region" {
  type    = string
  default = "sgp1"
}

variable "do_image" {
  type    = string
  default = "ubuntu-24-04-x64"
}

variable "do_size" {
  type    = string
  default = "s-1vcpu-512mb-10gb"
}

variable "do_ssh_key" {
  type    = string
  default = "www-1"
}

variable "ssh_private_key" {
  type      = string
  sensitive = true
}

variable "db_root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}
