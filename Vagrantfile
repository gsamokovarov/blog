Vagrant.configure(2) do |config|
  config.vm.box = 'hashicorp/precise64'

  # The 80 port may be taken by an already running application, you can
  # override it by specifying the PORT environment variable
  config.vm.network :forwarded_port, guest: 80, host: ENV.fetch('PORT', 8080)

  # Raise the open files limit to try to account for OSX + VirtualBox insanity.
  config.vm.provision :shell, inline: 'ulimit -n 4048'

  # Let Vagrant start offline.
  config.vm.box_check_update = false
end
