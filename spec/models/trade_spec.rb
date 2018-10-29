require 'rails_helper'

RSpec.describe Trade, type: :model do

	context "validations" do

		it "should have all the columns" do

			should have_db_column(:offer).of_type(:string)
			should have_db_column(:offer_status).of_type(:string)
			
		end

	end

	context "validates presence of offer" do

		it { is_expected.to validate_presence_of(:offer) }

	end

	context "trade associations" do

		it { is_expected.to belong_to(:posting) }
		it { is_expected.to belong_to(:user) }

	end

	describe "create a new trade with valid params" do

		let(:user){ User.create(
			first_name: "Matthew",
			last_name: "Cross",
			email: "mattyc246@gmail.com",
			password: "password",
			address: "123 street",
			city: "KL",
			state: "WPKL",
			country: "Malaysia",
			postcode: "50210",
			phone_number: "+60123456789"	
			)}
		let(:posting){Posting.create(
			title: "Nike Air Max 90 US6 White",
			brand: "Nike",
			color: "White",
			style: "Air Max 90",
			expected_offer: "Trade for peanuts",
			user_id: user.id,
			size: "US6",
			condition: "New",
			sneaker_type: "Running Shoe"
			)}
		let(:trade){Trade.create(
			posting_id: posting.id,
			user_id: user.id,
			offer: "Trade for walnuts"
			)}
		let(:bad_trade){Trade.create(
			offer: "Trade For Biscuits"
			)}

		# Happy Path

		it "should create a new trade" do

			expect(trade).to be_valid

		end

		# Unhappy Path

		it "should not be validated" do

			expect(bad_trade).to be_invalid

		end

		# Test against custom methods

		it "should return accepted" do

			trade.accept
			expect(trade.offer_status).to eq "accepted"

		end

		it "should return declined" do

			trade.decline
			expect(trade.offer_status).to eq "declined"

		end

	end

end