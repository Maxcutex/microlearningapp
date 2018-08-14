FactoryBot.define do
  factory :user_enrollments, class: 'UserEnrollment' do
    is_active true 
    notes { Faker::Lorem.paragraph(2, true, 4)}
    association :course, factory: :course
    association :user, factory: :fake_user
  end
end
