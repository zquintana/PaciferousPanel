require 'system'

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

namespace :nix do
	desc "Process pending users"
	task :process_users => :environment do
		users = User.all_pending
		default_shell = Setting.get('default_shell')
    	debug = Setting.get('debug')

		User.transaction do
			users.each do |user|
				return if System.uexists? user.unix_alias
				
				create_unix_user(user, default_shell, debug)				
			end
		end
	end

	# desc "Test user"
	# task :test => :environment do
	#	puts System.uexists? 'zach'
	#	puts System.uexists? 'zach2'
	# end
end