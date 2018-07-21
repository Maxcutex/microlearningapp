require 'faker'
require 'database_cleaner'

DatabaseCleaner.clean_with :truncation
Role.destroy_all
Role.create(
  [
    {
      :role_name => 'Administrator',
      :role_description => 'This is the main role and administrator of the system'
    },
    {
      :role_name => 'Instructor',
      :role_description => 'This is the owner of courses and can add/delete topics'
    },
    {
      :role_name => 'Student',
      :role_description => 'This is user of the application'
    }
  ]
)

User.destroy_all

User.create(
  [
    {
      :first_name => 'Nili', :last_name => 'Ach1', :username => 'nili678',
      :email => 'niliach1@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha1', :password_confirmation => 'iesha1'
    },
    {
      :first_name => 'Nili', :last_name => 'Ach2', :username => 'nili6782',
      :email => 'niliach2@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha2', :password_confirmation => 'iesha2'
    },
    {
      :first_name => 'Nili', :last_name => 'Ach3', :username => 'nili6783',
      :email => 'niliach3@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha3', :password_confirmation => 'iesha3'
    }
  ]
)

UserRole.destroy_all

UserRole.create(
  [
    { :user_id => 1, :role_id => 1, :is_active =>true },
    { :user_id => 2, :role_id => 2, :is_active =>true },
    { :user_id => 3, :role_id => 3, :is_active =>true }
  ]
)

# course categories
CourseCategory.destroy_all

CourseCategory.create(
  [
    {
      :category_name => 'Education', :is_active => true
    },
    {
      :category_name => 'Technology', :is_active => true
    },
    {
      :category_name => 'Political', :is_active => true
    }
  ]
)
# courses
Course.destroy_all

20.times do |index|
  Course.create(
    [
      {
        :name => Faker::Lorem.sentence(3,false,0).chop, :description => Faker::Lorem.sentence(7,false,0).chop,
        :icon => '', :level => 1,:instructor_id => 2, :no_days => 10, :category_id => 1, :course_image => '',
        :course_thumbnail => '', :is_active => true
      }
    ]
  )
end

# faq
