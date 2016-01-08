require 'spec_helper'

packages = ['python','git','wget']


describe "Red Hat Application server for #{ENV['TARGET_HOST']}" do
	packages.each do |p|
		describe package(p) do
			it { should be_installed }
		end
	end
	
	describe "Core services should be running" do
		describe service('sshd') do
			it { should be_enabled }
			it { should be_running }
		end

		describe port(22) do
			it { should be_listening }
		end

		describe package('iptables') do
			it { should be_installed }
		end

		describe service('postfix') do
			it { should be_enabled }
			it { should be_running }
		end
	end
end
