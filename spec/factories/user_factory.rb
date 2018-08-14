require 'faker'

FactoryBot.define do
  sequence(:username) { |n| "user#{n}" }
  sequence :email do |n|
    "00#{n}@mi6.com"
  end

  factory :user, class: 'User' do
    first_name 'User1'
    last_name 'Behive1'
    username 'myusername'
    email 'myemail@email.com'
    password 'aliceno'
    is_active true
  end

  factory :fake_user, parent: :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username
    email
    password 'aliceno'
    is_active true
  end

  
end
