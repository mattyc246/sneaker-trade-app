require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "POST #create" do

    let(:valid_params) {{first_name: "Willy", last_name: "Wonka", email:"willy@wonka.com", password:"willywonka", address:"Wonka Factory", city:"Wonkaville", state:"Nevada", country: "United States", postcode:"51111", phone_number:"+60123456789"}}
    let(:invalid_params) {{first_name: "Willy", last_name: "Wonka", email:"willy.wonka.com", password:"willy"}}

    let(:user){User.create(valid_params)}
    let(:user_2){User.create(invalid_params)}

    context "when given valid params" do
      it "should create a new user account" do

        expect(User.find_by(email: user.email)).not_to eq nil

      end

      it "should flash a success message" do

        User.create(valid_params)
        expect(flash[:success]).to eq "You have succesfully created your account! Sign in to get started!"

      end
    end

    context "when given invalid params" do
      it "should flash error message" do

        post :create, :user2 => invalid_params
        expect(flash[:danger]).to eq "Details are incorrect or email is already in use! Please try again!"

      end

      it "should not find a user by the email address given" do

        post :create, :user2 => invalid_params
        expect(User.find_by(email: params[:email])).to eq nil

      end
    end

  end

end