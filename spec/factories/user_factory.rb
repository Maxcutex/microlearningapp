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
  end
  # factory :dynamic_user, class: 'User' do
  #   first_name 'User1'
  #   last_name 'Behive1'
  #   username 'myusername'
  #   email 'myemail@email.com'
  #   password 'aliceno'
  # end
  factory :dynamic_user, parent: :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
  end

  factory :student_user, parent: :dynamic_user do
    after(:create) { |user| create(:student, user: user)}
  end

  factory :instructor_user, parent: :dynamic_user do
    after(:create) { |user| create(:instructor, user: user) }
  end
  factory :admin_user, parent: :dynamic_user do
    after(:create) { |user| create(:administrator, user: user)}
  end

  factory :user_student, parent: :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
    # factory :role do
    #   after(:create) do |user_student|
    #     create(:role_student, user_student: user_student)
    #   end
    # end
  end

  factory :user_instructor, parent: :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
    # factory :user_with_role_instructor do
    #   after(:create) do |user_instructor|
    #     create(:role_instructor, user_instructor: user_instructor)
    #   end
    # end
  end

  factory :user_admin, parent: :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    username
    email
    password 'aliceno'
    # factory :user_with_role_admin do
    #   after(:create) do |user_admin|
    #     create(:role_admin, user_admin: user_admin)
    #   end
    # end
  end
end
