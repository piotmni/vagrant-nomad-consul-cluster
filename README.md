### Requirements: ###
- [vagrant]( https://www.vagrantup.com/) 
- [virtualbox](https://www.virtualbox.org/)

this configuration use 3.5GB of RAM(every vm 512mb) and was tested on windows and linux environment. 


### Usage ###

definition of vms are stored in cluster.yml

Commands( you have to be in this folder): 

- `vagrant up` to start all vms
- `vagrant status` show started vms
- `vagrant ssh <vm name>` to ssh into vm 
- `vagrant destroy` to delete all vms




### TODO ###
- add  haproxy configuration
