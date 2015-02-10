# -*- mode: ruby -*-
# vi: set ft=ruby :

#win_2012_r2_box     = 'carmenpuccio/windows-server-2012-r2-test'
#win_2012_r2_box_url = 'https://atlas.hashicorp.com/carmenpuccio/boxes/windows-server-2012-r2-test'

standard_box               = 'sbp_windows_2012_r2_20141211_1'
standard_box_url           = 'https://artifacts.schubergphilis.com/artifacts/vagrant/sbp_windows_2012_r2_20141211_1.box'
standard_box_checksum      = '3c5f6bb14296a6539c4e8e286f7c30e00f4495df88e5e5ab572e5a8f9f323caf'
standard_box_checksum_type = 'sha256'

win_2012_r2_box = standard_box
win_2012_r2_box_url = standard_box_url

test_machines = {
  'test-dc' => {
    'box'      => win_2012_r2_box,
    'box_url'  => win_2012_r2_box_url,
    'ip'       => '192.168.56.5',
    'run_list' => [ 'recipe[test_windows_ad::setup_dc]' ]
  },
  'test-dm' => {
    'box'      => win_2012_r2_box,
    'box_url'  => win_2012_r2_box_url,
    'ip'       => '192.168.56.7',
    'run_list' => [ 'recipe[test_windows_ad::join_domain]' ]
  }
}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |global_config|
  test_machines.each_pair do |name, options|
    global_config.vm.define name do |config|

      config.vm.hostname = name
      # Every Vagrant virtual environment requires a box to build off of.
      config.vm.box                        = options['box']
      config.vm.box_url                    = options['box_url']

      config.vm.communicator = 'winrm'
      config.vm.guest = :windows

      port_80   = 1024 + rand(1024)
      # port_5985 = 1024 + rand(1024)
      # while port_5985 == port_80 do
      #   port_5985 = 1024 + rand(1024)
      # end

      config.vm.network 'private_network', ip: options['ip'], virtualbox__intnet: 'windows_ad'
      config.vm.network :forwarded_port, guest: 80,   host: port_80
      # config.vm.network :forwarded_port, guest: 5985, host: port_5985

      config.vm.provider 'virtualbox' do |vb|
        vb.gui = true
        vb.customize ['modifyvm', :id, "--nicpromisc1", "allow-all" ]
        vb.customize ['modifyvm', :id, "--nicpromisc2", "allow-all" ]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end

      config.omnibus.chef_version = '11.16.4'
      config.chef_zero.cookbooks    = [ 'test/fixtures/cookbooks', 'test/fixtures/test_cookbooks' ]

      config.vm.provision 'chef_client', run: 'always' do |chef|
        chef.log_level  = 'info'

        chef.custom_config_path = 'Vagrantfile.chef'
        chef.file_cache_path    = 'c:/var/chef/cache'

        chef.run_list = options['run_list']

        # You may also specify custom JSON attributes:
        chef.json = { 
          'windows_ad' => { 'dc_ip' => '192.168.56.5' }
        }
      end
    end
  end
end
