Vagrant.require_version ">= 1.5"

Vagrant.configure("2") do |config|
  config.vm.box = "codete/jessie64"
  config.vm.hostname = "codete-sandbox"

  config.vm.provider :virtualbox do |v|
    v.check_guest_additions = false
    host = RbConfig::CONFIG['host_os']

    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/kB//'`.to_i / 1024 / 4
    else
      cpus = 2
      mem = 1024
    end

    v.name = "codete-sandbox"
    v.customize [
      "modifyvm", :id,
      "--name", "codete-sandbox",
      "--memory", mem,
      "--natdnshostresolver1", "on",
      "--cpus", cpus
    ]
  end

  config.vm.network :private_network, ip: "192.168.4.11"
  config.ssh.forward_agent = true

  config.vm.synced_folder "./", "/vagrant",
    :type => "nfs",
    :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']

  config.vm
end
