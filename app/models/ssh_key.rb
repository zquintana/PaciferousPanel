class SshKey < ActiveRecord::Base
	belongs_to :user

	# after_create :generate_allowed

	def to_s 
		self.key
	end

	protected
	def generate_allowed
		AuthorizedKeys.generate(user)
	end
end
