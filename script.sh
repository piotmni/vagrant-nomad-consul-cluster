function basic(){
  apt-get install -y curl wget unzip
}

function nomad(){
  echo Downloading and installing nomad....
  cd /tmp
  curl -sSL https://releases.hashicorp.com/nomad/1.0.1/nomad_1.0.1_linux_amd64.zip -o nomad.zip

  unzip nomad.zip
  sudo chmod +x nomad
  sudo mv nomad /usr/bin/nomad

  sudo mkdir -p /etc/nomad.d
  sudo chmod a+w /etc/nomad.d
}

function consul(){
  echo Downloading and installing consul...
  cd /tmp
  curl -sSL https://releases.hashicorp.com/consul/1.8.0/consul_1.8.0_linux_amd64.zip -o consul.zip

  unzip consul.zip
  sudo chmod +x consul
  sudo mv consul /usr/bin/consul

  sudo mkdir -p /etc/consul.d
  sudo chmod a+w /etc/consul.d


}

function get_ip(){

IP_ADDR=` ip -4 addr show dev enp0s8 | awk '/inet/ {print $2}' | rev | cut -c4- | rev`
read -d '' nomad_conf << EOF
  bind_addr = "${IP_ADDR}"
  advertise {
    http = "${IP_ADDR}"
    rpc = "${IP_ADDR}"
    serf = "${IP_ADDR}"
  }
  addresses {
    http = "${IP_ADDR}"
    rpc = "${IP_ADDR}"
    serf = "${IP_ADDR}"
  }
  consul {
  address = "${IP_ADDR}:8500"
  }
EOF

read -d '' consul_conf << EOF
  bind_addr  = "${IP_ADDR}"
  client_addr  = "${IP_ADDR}"
EOF
read -d '' dns_conf << EOF
  nameserver ${IP_ADDR}
EOF

}

function start_nomad(){
  if [ "$1" == "server" ]; then
    sudo cp /vagrant/nomad/server.hcl /etc/nomad.d/nomad.hcl
  else
    sudo cp /vagrant/nomad/client.hcl /etc/nomad.d/nomad.hcl
  fi

  echo $nomad_conf >> /etc/nomad.d/nomad.hcl
  sudo cp /vagrant/nomad/nomad.service /etc/systemd/system/nomad.service
  sudo systemctl daemon-reload
  sudo systemctl enable nomad && sudo systemctl start nomad

}

function start_consul(){
  if [ "$1" == "server" ]; then
    sudo cp /vagrant/consul/server.hcl /etc/consul.d/consul.hcl
  else
    sudo cp /vagrant/consul/client.hcl /etc/consul.d/consul.hcl
  fi

  echo $consul_conf >> /etc/consul.d/consul.hcl
  sudo cp /vagrant/consul/consul.service /etc/systemd/system/consul.service
  sudo systemctl daemon-reload

  sudo sed -i "1s/^/$dns_conf \n /" /etc/resolv.conf
  sudo systemctl enable consul && sudo systemctl start consul

}


function install_docker(){
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl enable docker && sudo systemctl start docker
}

export DEBIAN_FRONTEND=noninteractive

basic
consul
nomad
get_ip

if [ "$1" == "client" ]; then
  install_docker
fi

start_consul $1
start_nomad $1
