require 'faker'

FactoryBot.define do
  factory :role_admin, :class => 'Role' do
    role_name 'Administratior'
    role_description 'This is administrator for the application'
  end
  factory :role_instructor, :class => 'Role' do
    role_name 'Instructor'
    role_description 'This is Instructor for the application'
  end
  factory :role_student, :class => 'Role' do
    role_name 'Student'
    role_description 'This is student for the application'
  end
  factory :user, :class => 'User' do
    first_name 'User1'
    last_name 'Behive1'
    username 'myusername'
    email 'myemail@email.com'
    password 'aliceno'
  end

  factory :user_student, parent: :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
  end

  factory :user_instructor, :class => 'User' do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
  end

  factory :user_admin, :class => 'User' do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
    #association :role_student
  end

  sequence(:username) { |n| "user#{n}" }
  sequence :email do |n|
    "00#{n}@mi6.com"
  end
end