require 'faker'

FactoryBot.define do
  factory :role_admin, class: 'Role' do
    role_name 'Administrator'
    role_description 'This is administrator for the application'
  end

  factory :role_instructor, class: 'Role' do
    role_name 'Instructor'
    role_description 'This is Instructor for the application'
  end

  factory :role_student, class: 'Role' do
    role_name 'Student'
    role_description 'This is student for the application'
  end

  # factory :role, class: 'Role' do
  #   role_name 'Administratior'
  #   role_description 'This is administrator for the application'
  # end
end
