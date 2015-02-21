module System
	def self.uid(user)
		`id -u #{user}`
	end

	def self.uexists?(user)
		self.uid user
		$?.success?
	end
end