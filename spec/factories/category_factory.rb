require 'faker'

FactoryBot.define do
  factory :category, class: 'CourseCategory' do
    category_name 'Education'
    is_active true
  end
end
