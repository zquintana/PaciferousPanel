class Profile < ActiveRecord::Base

	belongs_to :user

	def full_name
		"%s%s" % [self.first_name, self.last_name ? " #{self.last_name}" : ""]
	end
end
