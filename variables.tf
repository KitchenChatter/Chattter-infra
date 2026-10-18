variable "docker_socket_path" {
  type        = string
  description = "The local absolute path to the Mac Docker Desktop daemon socket"
  default     = "unix:///Users/mrOwens/.docker/run/docker.sock"
}

variable "web_server_external_port" {
  type        = number
  description = "The external host port exposed on your Mac browser"
  default     = 8080
}
