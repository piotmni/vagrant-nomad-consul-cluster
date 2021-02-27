datacenter = "dc1"
data_dir = "/tmp/consul"
# consul keygen

retry_join = ["172.17.8.101", "172.17.8.102", "172.17.8.103"]

server = true  // bool

bootstrap_expect = 3
performance {
  raft_multiplier = 1
}

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
