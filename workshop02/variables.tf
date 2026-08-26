variable "do_token" {
  type      = string
  sensitive = true
}

variable "do_region" {
  type    = string
  default = "sgp1"
}

variable "ssh_key_name" {
  type    = string
  default = "www2"
}

variable "ssh_private_key" {
  type    = string
  default = "/root/.ssh/id_ed25519"
}

variable "codeserver_domain" {
  type    = string
  default = ""
}

variable "codeserver_password" {
  type      = string
  sensitive = true
}
