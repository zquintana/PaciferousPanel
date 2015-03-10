require 'system'
require 'capistrano/all'

def create_unix_user(user, default_shell, debug)
    if debug == true
      	user.status = User.PendingStatusType
      	return user.save
    end

    command = "adduser --disabled-password"
    command += " -s #{default_shell}" if default_shell
    command += " #{user.unix_alias}"
    `#{command}`

    if $?.success? == false
      	user.status = User.PendingStatusType
      	return user.save
    end

    user.status = User.EnabledStatusType
    user.save
end

'''
class ServerInfo
	include Capistrano::DSL

	def initialize
		load "capistrano/defaults.rb"
		load stage_config_path.join("production.rb")
		# load deploy_config_path
		load "capistrano/#{fetch(:scm)}.rb"

		configure_backend
	end

	def self.info 
		@me ||= new
	end

	def self.config 
		info.primary :app
	end
end
'''

namespace :nix do
	desc "Process pending users"
	task :process_users => :environment do
		users 			= User.all_pending
		default_shell 	= Setting.get('default_shell')
    	debug 		= Setting.get('debug')
		
		users.each do |user|
			puts "Creating user for #{user.id}"
			if !System.uexists? user.unix_alias
				create_unix_user(user, default_shell, debug)
			else
				puts "User already exists for #{user.unix_alias}"
				user.status = User.EnabledStatusType
				user.save
			end

			mkdir_p "#{user.home_path}/.ssh"
			touch "#{user.home_path}/.ssh/authorized_keys"
			chmod 0700, "#{user.home_path}/.ssh"
			chmod 0600, "#{user.home_path}/.ssh/authorized_keys"
			chown_R user.unix_alias, user.unix_alias, "#{user.home_path}/.ssh"

			mkdir_p "#{user.home_path}/www"
			chown_R user.unix_alias, user.unix_alias, "#{user.home_path}/www"
		end
	end

	desc "Process new ssh keys"
	task :process_keys => :environment do 
		ssh_key_cache = 'ssh_key_last_checked'

		users = []
		if Rails.cache.exist? ssh_key_cache
			last_checked = Rails.cache.read ssh_key_cache
			users 	= User.where(id: SshKey.select('user_id').where('created_at >= ? OR updated_at >= ?', last_checked, last_checked).distinct)
		else
			users 	= User.where(id: SshKey.select('user_id').distinct) 	
		end

		Rails.cache.write ssh_key_cache, Time.now
		return if users.length < 1

		users.each do |user|
			f = "#{user.home_path}/.ssh/authorized_keys"
			File.open f, 'w' do |f|
				f.puts user.ssh_keys.all
			end

			chmod 0700, "#{user.home_path}/.ssh"
			chmod 0600, "#{user.home_path}/.ssh/authorized_keys"
			chown_R user.unix_alias, user.unix_alias, "#{user.home_path}/.ssh"
		end
	end

	# desc "Test user"
	# task :test => :environment do
	#	puts System.uexists? 'zach'
	#	puts System.uexists? 'zach2'
	#	puts ServerInfo.config.user
	# end
end