Vagrant.configure(2) do |config|
  machines = [
    ["centos-6",       "chef/centos-6.6",     "192.168.33.100"],
    ["centos-7",       "chef/centos-7.0",     "192.168.33.101"],
    ["debian-wheezy",  "deb/wheezy-amd64",    "192.168.33.110"],
    ["debian-jessie",  "deb/jessie-amd64",    "192.168.33.111"],
    ["ubuntu-precise", "hashicorp/precise64", "192.168.33.120"],
    ["ubuntu-trusty",  "ubuntu/trusty64",     "192.168.33.121"],
  ]

  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.memory = 256
  end

  machines.each do |machine|
    config.vm.define machine[0] do |m|
      m.vm.box = machine[1]
      m.vm.network "private_network", ip: machine[2]

      # For Ansible to work on CentOS 6 boxes
      if machine[0] == "centos-6"
        m.vm.provision "shell", inline: "sudo yum install -y libselinux-python"
      end
      # Use nearest mirror in Debian, which may help prevent network problems when installing packages, e.g. hash sum
      # mismatch
      if machine[0].start_with? "debian"
        m.vm.provision "shell", inline: <<-SHELL
          # Run only on the first provisioning
          if [ ! -f /usr/bin/netselect-apt ]; then
            sudo apt-get update
            sudo apt-get install -y netselect-apt &&
            sudo netselect-apt -ns -o /etc/apt/sources.list #{machine[0][7..-1]}
          fi
        SHELL
      end
      # Use nearest mirror in Ubuntu, which may help prevent network problems when installing packages, e.g. hash sum
      # mismatch
      if machine[0].start_with? "ubuntu"
        m.vm.provision "shell", inline: <<-SHELL
          sudo sed -i 's#http://us.archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' \
            /etc/apt/sources.list
        SHELL
      end

      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.groups = { "test" => [ machine[0] ] }
        ansible.verbose = 'vv'
      end
    end
  end
end
