
data_dir =  "/tmp/server"

server {
  enabled          = true
  bootstrap_expect = 3
  #server join moved inside server section because when it was outside this section it did not work
  server_join {
    retry_join = [ "nomad.service.consul" ]
    retry_max = 3
    retry_interval = "15s"
  }

}
