require 'rails_helper'

describe "Signing Up for an account", type: :feature do
  # Happy Path
  it "Signs up for a new account" do
    visit '/sign_up'
    within(".vertical-center") do
      fill_in 'user[first_name]', with: 'Steve'
      fill_in 'user[last_name]', with: 'Jobs'
      fill_in 'user[email]', with: 'steve@apple.com'
      fill_in 'user[password]', with: 'stevejobs123'
      fill_in 'user[address]', with: 'No.1 Apple Road'
      fill_in 'user[city]', with: 'Cupertino'
      fill_in 'user[state]', with: 'California'
      select 'United States', :from => 'user[country]'
      fill_in 'user[postcode]', with: '90210'
      fill_in 'user[phone_number]', with: '+60123456789'
    end
    click_button 'Register Account'
    expect(page).to have_content 'You have succesfully created your account! Sign in to get started!'
  end
  # Unhappy Path
  it "displays error message for incorrect details" do
    visit '/sign_up'
    within(".vertical-center") do
      fill_in 'user[first_name]', with: 'Alain'
      fill_in 'user[last_name]', with: 'Prost'
      fill_in 'user[email]', with: 'alain.racing.com'
      fill_in 'user[password]', with: 'racing'
    end
    click_button 'Register Account'
    expect(page).to have_content 'Details are incorrect or email is already in use! Please try again!'
  end
end