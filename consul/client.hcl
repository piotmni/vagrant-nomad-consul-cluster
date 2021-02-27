datacenter = "dc1"
data_dir = "/tmp/consul"

retry_join = ["172.17.8.101","172.17.8.102","172.17.8.103"]
server = false // bool

connect {
  enabled = true
}

ports {
  dns = 53
}

recursors = [
  "1.1.1.1",
  "8.8.8.8",
]

ui = true
