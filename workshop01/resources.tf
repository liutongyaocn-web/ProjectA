resource "docker_network" "bgg_net" {
  name = "bgg-net"
}

resource "docker_image" "database" {
  name         = "chukmunnlee/bgg-database:${var.database_version}"
  keep_locally = false
}

resource "docker_image" "backend" {
  name         = "chukmunnlee/bgg-backend:${var.backend_version}"
  keep_locally = false
}

resource "docker_container" "database" {
  name  = "bgg-database"
  image = docker_image.database.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}"
  ]

  networks_advanced {
    name = docker_network.bgg_net.name
  }

  restart = "always"
}

resource "docker_container" "backend" {
  count = var.backend_instance_count

  name  = "bgg-backend-${count.index + 1}"
  image = docker_image.backend.image_id

  env = [
    "BGG_DB_USER=root",
    "BGG_DB_PASSWORD=${var.db_root_password}",
    "BGG_DB_HOST=bgg-database",
    "BGG_DB_PORT=3306"
  ]

  networks_advanced {
    name = docker_network.bgg_net.name
  }

  ports {
    internal = 3000
    external = 3000 + count.index
  }

  restart = "always"

  depends_on = [
    docker_container.database
  ]
}

data "digitalocean_ssh_key" "www_1" {
  name = var.do_ssh_key
}

resource "digitalocean_droplet" "reverse_proxy" {
  name   = "bgg-reverse-proxy"
  image  = var.do_image
  region = var.do_region
  size   = var.do_size

  ssh_keys = [
    data.digitalocean_ssh_key.www_1.id
  ]
}
