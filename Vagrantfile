Vagrant.configure("2") do |config|
  
  config.vm.define "puppetmaster" do |master|
    master.vm.box = "bento/ubuntu-16.04"
    master.vm.hostname = 'puppetmaster' 
	master.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "puppetmaster"]
	  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    master.vm.network "private_network",  ip: "192.168.56.3/24", type: "static"
    master.vm.boot_timeout = 30
	master.vm.provision "shell",   
	   inline: "sudo /bin/sh /home/vagrant/vagrant1.sh"
  end  
   
  config.vm.define "puppetclient" do |client|
    client.vm.box = "bento/ubuntu-16.04"
    client.vm.hostname = 'puppetclient'  
    client.vm.provider :virtualbox do |virs|
      virs.customize ["modifyvm", :id, "--memory", 1024]
      virs.customize ["modifyvm", :id, "--name", "puppetclient"] 
      virs.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]    	  
    end 
    client.vm.network "private_network",  ip: "192.168.56.4/24", type: "static"
	client.vm.boot_timeout = 45
	client.vm.provision "shell",   
	   inline: "sudo /bin/sh /home/vagrant/vagrant1.sh"
  end
end