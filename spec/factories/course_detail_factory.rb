FactoryBot.define do
  factory :course_detail, class: 'CourseDetail' do
    day_number { Faker::Name.first_name }
    day_topic { Faker::Name.last_name }
    day_details 1
    course_id 10
    association :course, factory: :course
  end
end
