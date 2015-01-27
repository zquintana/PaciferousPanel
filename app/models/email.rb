class Email < ActiveRecord::Base

	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: true

	belongs_to :domain
	
end
