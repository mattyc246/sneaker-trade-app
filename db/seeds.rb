# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = '123456789'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['address'] = Faker::Address.street_address
    user['city'] = Faker::Address.city
    user['state'] = Faker::Address.state
    user['country'] = Faker::Address.country
    user['postcode'] = Faker::Address.zip_code
    user['phone_number'] = Faker::PhoneNumber.phone_number

    User.create(user)
  end
end 

posting = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    posting['title'] = Faker::Hipster.sentence
    posting['brand'] = ["Adidas","Jordan","Nike","Puma","Reebok","Vans", "Yeezy"].sample
    posting['style'] = Faker::Hipster.word
    posting['color'] = Faker::Color.color_name
    posting['expected_offer'] = Faker::Hipster.sentence
    posting['size'] = ['US1','US2','US3','US4','US4.5','US5','US5.5','US6','US6.5','US7','US7.5',
				'US8','US8.5','US9','US9.5','US10','US10.5','US11','US11.5','US12','US12.5'].sample
    posting['condition'] = ['1 (Heavily Worn)','2','3','4','5','6','7','8','9','10 (Brand New)'].sample
    posting['sneaker_type'] = ['High Top', 'Low Top', 'Basketball Shoe', 'Running Shoe', 'Tennis Shoe'].sample
    posting['user_id'] = uids.sample

    Posting.create(posting)
  end
end