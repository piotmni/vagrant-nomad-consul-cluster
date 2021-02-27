data_dir =  "/tmp/client"
# client config
client {
  server_join {
    retry_join = ["nomad.service.consul"]
    retry_max = 3
    retry_interval = "15s"
  }

  enabled = true
  servers = ["nomad.service.consul"]
  network_interface = "enp0s8"

  node_class = "vps"

}

plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
