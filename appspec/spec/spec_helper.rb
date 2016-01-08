require 'serverspec'
require 'rubygems'
require 'bundler/setup'
require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

#include Serverspec::Helper::Ssh
#include Serverspec::Helper::DetectOS
#include Serverspec::Helper::Properties

properties = YAML.load_file('properties.yml')

RSpec.configure do |c| 
	c.host	= ENV['TARGET_HOST']
	set_property properties[c.host]
	options	= Net::SSH::Config.for(c.host)
	KEYS	= [`cat /home/ec2-user/.ssh/superSecretkey.pem`]
	user	= 'ec2-user'
	c.ssh	= Net::SSH.start(c.host, user, :key_data => KEYS, :keys_only => TRUE)
end

set :backend, :exec
