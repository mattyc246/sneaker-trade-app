require 'rails_helper'

RSpec.describe User, type: :model do

	context "validations" do

		it "should have all the columns" do

			should have_db_column(:first_name).of_type(:string)
			should have_db_column(:last_name).of_type(:string)
			should have_db_column(:email).of_type(:string)
			should have_db_column(:password_digest).of_type(:string)
			should have_db_column(:address).of_type(:string)
			should have_db_column(:city).of_type(:string)
			should have_db_column(:state).of_type(:string)
			should have_db_column(:postcode).of_type(:string)
			should have_db_column(:country).of_type(:string)
			should have_db_column(:phone_number).of_type(:string)

		end

		context "validates presence & uniqueness of email" do

			it { is_expected.to validate_presence_of(:email) }
			it { is_expected.to validate_uniqueness_of(:email) }

		end

		context "validates the password" do

			it { is_expected.to validate_presence_of(:password) }
			it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20) }

		end

		context "validates presence of all other information" do

			it { is_expected.to validate_presence_of(:address) }
			it { is_expected.to validate_presence_of(:city) }
			it { is_expected.to validate_presence_of(:state) }
			it { is_expected.to validate_presence_of(:postcode) }
			it { is_expected.to validate_presence_of(:country) }
			it { is_expected.to validate_presence_of(:phone_number) }

		end
	end
		# Happy Path for user creation

		describe "should create a user when all correct params are given" do

			When(:new_user) {User.new(
				first_name: "Steve",
				last_name: "Jobs",
				email: "stevejobs@apple.com",
				password: "apple12345",
				address: "No.1 Apple Road",
				city: "Cupertino",
				state: "California",
				country: "United States",
				postcode: "90210",
				phone_number: "+60123456789"
				)}
			Then { new_user.save == true }

		end

		# Unhappy Path for user creation

		describe "will not create a user without the correct number of params" do

			When(:new_user) {User.new(
				first_name: "Steve",
				last_name: "Jobs",
				email: "stevejobs@apple.com",
				password: "steve"
				)}
			Then { new_user.save == false }
		end

		describe "should permit only valid password length" do

			let(:good_user){User.create(
				first_name: "Steve",
				last_name: "Jobs",
				email: "stevejob@apple.com",
				password: "apple12345",
				address: "No.1 Apple Road",
				city: "Cupertino",
				state: "California",
				country: "United States",
				postcode: "90210",
				phone_number: "+60123456789"
				  )}
			let(:bad_user){User.create(
				first_name: "Steve",
				last_name: "Jobs",
				email: "stevejbs@apple.com",
				password: "apple",
				address: "No.1 Apple Road",
				city: "Cupertino",
				state: "California",
				country: "United States",
				postcode: "90210",
				phone_number: "+60123456789"
				  )}

			# Happy path with valid password

			it "should allow with valid length" do

				expect(good_user).to be_valid

			end

			# Unhappy path with invalid password

			it "should not allow with invalid length" do

				expect(bad_user).to be_invalid

			end


		end

		context "user associations" do

			it { is_expected.to have_many(:postings) }
			it { is_expected.to have_many(:trades) }

		end

end