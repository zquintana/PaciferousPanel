class Domain < ActiveRecord::Base

	belongs_to :user
	belongs_to :ip
	has_many :emails

	@@StatusTypes = {
		:disabled => 0, 
		:pending => 1, 
		:enabled => 2
	}

	@@PendingStatusType = 1
	@@EnabledStatusType = 2


	def status_text
		return @@StatusTypes.index(self.status) if self.status

		'disabled'
	end

	class << self
		def StatusTypes
			@@StatusTypes
		end

		def all_pending
			self.where(status: @@PendingStatusType)
		end

		def EnabledStatusType
			@@EnabledStatusType
		end
	end
end
