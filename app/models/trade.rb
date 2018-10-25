class Trade < ApplicationRecord
	belongs_to :user
	belongs_to :posting

	validates :offer, presence: true
	validates :offer_status, presence: true
end
