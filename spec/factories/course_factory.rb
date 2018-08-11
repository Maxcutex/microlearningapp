FactoryBot.define do
  factory :course, class: 'Course' do
    name { Faker::Name.first_name }
    description { Faker::Name.last_name }
    level { Faker::Number.between(1, 3) }
    association :course_category, factory: :category
    association :instructor, factory: :fake_user

    factory :course_with_details do
      transient do
        details_count 10
      end

      after(:create) do |course, evaluator|
        create_list(:course_detail, evaluator.details_count, course: course)
      end
    end
  end
end
