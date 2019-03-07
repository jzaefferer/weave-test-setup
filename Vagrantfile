# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  (1..3).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.network "private_network", ip: "20.20.20.2#{i}"
    end
  end

  # install docker and weave
  config.vm.provision "shell", inline: <<-SHELL
    set -ex
    if docker --version ; then
      exit
    fi
    # install docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    # install weave
    #weave_version=v2.3.0
    weave_version=latest_release
    sudo curl -L https://github.com/weaveworks/weave/releases/download/$weave_version/weave -o /usr/bin/weave
    sudo chmod a+x /usr/bin/weave
    sudo chmod a+x /vagrant/start.sh
  SHELL

  # set up individual hostnames and weave names, then starting docker and weave
  (1..3).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.provision "shell", inline: <<-SHELL
        set -ex
        # setup weave as a service
        sudo cp /vagrant/weave.service /etc/systemd/system/weave.service
        sudo sed -i 's/NAME/#{i}/' /etc/systemd/system/weave.service
        sudo cp /vagrant/etc-sysconfig-weave /etc/sysconfig/weave
        echo "node#{i}" | sudo tee /etc/hostname
        sudo hostname -F /etc/hostname
        sudo systemctl start docker
        sudo systemctl start weave
      SHELL
    end
  end

end
