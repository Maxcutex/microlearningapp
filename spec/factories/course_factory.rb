FactoryBot.define do
  factory :course, class: 'Course' do
    name { Faker::Name.first_name }
    description { Faker::Name.last_name }
    level 1
    association :course_category, factory: :category
    association :instructor, factory: :fake_user
  end
end
