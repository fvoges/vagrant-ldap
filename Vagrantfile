BOX_IMAGE = "bento/ubuntu-18.04"

Vagrant.configure("2") do |config|
  config.vm.define "ldap-server" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.synced_folder ".", "/vagrant"
    subconfig.vm.network "private_network", ip: "10.0.1.100"
    subconfig.vm.network "forwarded_port", guest: 389, host: 389
    subconfig.vm.provision "shell" do |s|
      s.path =  "install_openldap.sh"
    end
  end
end
