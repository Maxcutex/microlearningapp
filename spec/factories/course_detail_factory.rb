FactoryBot.define do
  factory :course_detail, class: 'CourseDetail' do
    day_number
    day_topic { Faker::Lorem.sentences(1) }
    day_details { Faker::Lorem.paragraph(2, true, 4)}
    association :course, factory: :course
  end
  sequence :day_number do |n|
    n
  end
end
