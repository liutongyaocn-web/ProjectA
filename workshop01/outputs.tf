locals {
  docker_host_ip = replace(
    replace(var.docker_host, "tcp://", ""),
    ":2376",
    ""
  )
}

output "reverse_proxy_ip" {
  description = "Public IPv4 address of the Nginx reverse proxy"
  value       = digitalocean_droplet.reverse_proxy.ipv4_address
}

output "backend_endpoints" {
  description = "Backend application endpoints"
  value = [
    for i in range(var.backend_instance_count) :
    "${local.docker_host_ip}:${3000 + i}"
  ]
}

output "reverse_proxy_ssh" {
  description = "SSH target for the reverse proxy"
  value       = "root@${digitalocean_droplet.reverse_proxy.ipv4_address}"
}
