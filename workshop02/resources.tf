data "digitalocean_ssh_key" "workshop5" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "codeserver" {
  image  = "ubuntu-22-04-x64"
  name   = "codeserver"
  region = var.do_region
  size   = "s-1vcpu-1gb"

  ssh_keys = [
    data.digitalocean_ssh_key.workshop5.id
  ]
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.yaml"

  content = templatefile("${path.module}/inventory.yaml.tftpl", {
    ssh_private_key     = var.ssh_private_key
    codeserver_ip       = digitalocean_droplet.codeserver.ipv4_address
    codeserver_domain   = var.codeserver_domain
    codeserver_password = var.codeserver_password
  })
}

output "codeserver_ip" {
  value = digitalocean_droplet.codeserver.ipv4_address
}
