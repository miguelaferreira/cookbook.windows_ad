# -*- mode: ruby -*-
# vi: set ft=ruby :

win_2012_r2_box     = 'carmenpuccio/windows-server-2012-r2-test'
win_2012_r2_box_url = 'https://atlas.hashicorp.com/carmenpuccio/boxes/windows-server-2012-r2-test'

test_machines = {
  'dc' => {
    'box'      => win_2012_r2_box,
    'box_url'  => win_2012_r2_box_url,
    'run_list' => [ 'recipe[test_windows_ad::setup_dc]' ]
  },
  'non-dc' => {
    'box'      => win_2012_r2_box,
    'box_url'  => win_2012_r2_box_url,
    'run_list' => [ 'recipe[test_windows_ad::join_domain]' ]
  }
}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |global_config|
  test_machines.each_pair do |name, options|
    global_config.vm.define name do |config|
      config.vm.box = name
      # Every Vagrant virtual environment requires a box to build off of.
      config.vm.box                        = options['box']
      config.vm.box_url                    = options['box_url']

      config.vm.communicator = 'winrm'
      config.vm.guest = :windows

      port_80   = 1024 + rand(1024)
      port_5985 = 1024 + rand(1024)
      while port_5985 == port_80 do
        port_5985 = 1024 + rand(1024)
      end

      config.vm.network :forwarded_port, guest: 80,   host: port_80
      config.vm.network :forwarded_port, guest: 5985, host: port_5985

      config.vm.provider 'virtualbox' do |vb|
        vb.gui = true
        vb.customize ['modifyvm', :id, "--nicpromisc1", "allow-all" ]
        vb.customize ['modifyvm', :id, "--nicpromisc2", "allow-all" ]
      end

      config.omnibus.chef_version = '11.16.4'
      config.chef_zero.cookbooks    = [ 'test/fixtures/cookbooks', 'test/fixtures/test_cookbooks' ]

      config.vm.provision 'chef_client', run: 'always' do |chef|
        chef.log_level  = 'info'

        chef.custom_config_path = 'Vagrantfile.chef'
        chef.file_cache_path    = 'c:/var/chef/cache'

        chef.run_list = options['run_list']

        # You may also specify custom JSON attributes:
        chef.json = { }
      end
    end
  end
end
