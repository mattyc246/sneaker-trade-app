class Trade < ApplicationRecord
	belongs_to :user
	belongs_to :posting

	validates :offer, presence: true
	validates :offer_status, presence: true
	before_validation :set_status, on: [:create]

	def set_status

		self.offer_status = "pending"

	end
end
