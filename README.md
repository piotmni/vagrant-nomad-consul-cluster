### Requirements: ###
- [vagrant]( https://www.vagrantup.com/) 
- [virtualbox](https://www.virtualbox.org/)

this configuration use 3GB of RAM(every vm 512mb) and was tested on windows environment. if you run 
on linux machine you can have problem with virtualbox kernel module.


### Usage ###

definition of vms are stored in cluster.yml

Commands( you have to be in this folder): 

- `vagrant up` to start all vms
- `vagrant status` show started vms
- `vagrant ssh <vm name>` to ssh into vm 
- `vagrant destroy` to delete all vms


### TODO ###
- correct port forwarding to host machine
- add consul 
- correct docker installation on nomad-clients