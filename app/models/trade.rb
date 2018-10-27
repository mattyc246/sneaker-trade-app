class Trade < ApplicationRecord
	belongs_to :user
	belongs_to :posting

	validates :offer, presence: true
	validates :offer_status, presence: true
	before_validation :set_status, on: [:create]

	def set_status

		self.offer_status = "pending"

	end

	def accept

		self.offer_status = 'accepted'
		self.save

	end

	def decline

		self.offer_status = 'declined'
		self.save

	end
end
