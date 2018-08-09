FactoryBot.define do
  factory :student, class: 'UserRole' do
    association :role, factory: :role_student
    association :user, factory: :user
    is_active true
  end

  factory :instructor, class: 'UserRole' do
    association :role, factory: :role_instructor
    association :user, factory: :user
    is_active true
  end
  factory :administrator, class: 'UserRole' do
    association :role, factory: :role_admin
    association :user, factory: :user
    is_active true
  end
end
