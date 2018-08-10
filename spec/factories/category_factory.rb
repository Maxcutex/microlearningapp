require 'faker'

FactoryBot.define do
  factory :category, class: 'CourseCategory' do
    category_name
    is_active true
  end

  sequence(:category_name) { |n| "My Category#{n}" }
end
