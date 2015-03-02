##
# Manages authorized keys file for user
#
#
##

class AuthorizedKeys
	include FileUtils


	class << self
		def file(user)
			"#{user.home_path}/.ssh/authorized_keys"
		end

		def generate(user)
			File.open self.file(user), 'w' do |f|
				f.puts user.ssh_keys.all
			end
		end
	end
end