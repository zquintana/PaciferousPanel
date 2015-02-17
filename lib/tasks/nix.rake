
namespace :nix do
	desc "Process pending users"
	task :process_users => :environment do
		users = User.all_pending

		users.each do |user|
			user.create_unix_user
		end
	end
end