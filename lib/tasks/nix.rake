
namespace :nix do
	desc "Process pending users"
	task :process_users => :environment do
		users = User.all_pending

		users.each do |user|
			puts "User #{user.email} -> #{user.unix_alias}\n"
		end
	end
end