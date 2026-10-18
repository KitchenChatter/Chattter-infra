# 1. The Provider Block: Tells Terraform to use Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
	host = "unix:///Users/mrOwens/.docker/run/docker.sock"
}


# 2. The Resource Block: Download the official Nginx web server image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# 3. The Resource Block: Spin up a container and map it to your Mac's ports
resource "docker_container" "web_server" {
  image = docker_image.nginx.image_id
  name  = "chattter_local_webserver"

  ports {
    internal = 80
    external = 8080
  }
}
