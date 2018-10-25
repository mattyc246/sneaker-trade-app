class Trade < ApplicationRecord
	belongs_to :user
	belongs_to :posting

	validates :offer, presence: true
	validates :offer_status, presence: true

	def self.set_status

		self.offer_status = "Pending"

	end
end
