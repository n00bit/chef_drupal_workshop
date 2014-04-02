#   Install with command

Vagrant.require_plugin 'vagrant-hostsupdater'

Vagrant.configure("2") do |config|
  config.vm.define "webserver" do |machine|
    machine.hostsupdater.aliases = ["hw2.n00bit.no-ip.org", "hw3.n00bit.no-ip.org"]

    machine.vm.network :private_network, ip: "10.0.0.10"

    machine.vm.synced_folder ".", "/vagrant", :disabled => false, :nfs => true, :windows__nfs_options => ["-exec"]
    machine.vm.synced_folder "./www/hw2", "/var/www/hw2", :disabled => false, :nfs => true, :windows__nfs_options => ["-exec"]
    machine.vm.synced_folder "./www/hw3", "/var/www/hw3", :disabled => false, :nfs => true, :windows__nfs_options => ["-exec"]

    machine.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks", "chef/applications"]
      chef.roles_path = "chef/roles"
      chef.add_role "webserver"
    end

     machine.vm.provider :virtualbox do |vb, override|
       vb.customize ["modifyvm", :id, "--memory", "1024"]
       vb.customize ["modifyvm", :id, "--cpus", "1"]
       override.vm.box = "ubuntu"
       override.vm.box_url = "http://files.vagrantup.com/precise32.box"
     end

     config.vm.provider :digital_ocean do |provider, override|
       override.omnibus.chef_version = "10.14.2"
       override.ssh.private_key_path = '~/.ssh/id_rsa'
       override.vm.box = 'digital_ocean'
       override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

       provider.client_id = ''
       provider.api_key = ''
       provider.image = 'Ubuntu 12.04.3 x32'
       provider.region = 'Amsterdam 2'
     end
  end
end
