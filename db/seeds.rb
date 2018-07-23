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
      :first_name => 'David', :last_name => 'Plate', :username => 'nili6782',
      :email => 'niliach2@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha2', :password_confirmation => 'iesha2'
    },
    {
      :first_name => 'Femi', :last_name => 'Lanre', :username => 'nili6783',
      :email => 'niliach3@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha3', :password_confirmation => 'iesha3'
    },
    {
      :first_name => 'Steve', :last_name => 'Nuria', :username => 'nili6784',
      :email => 'niliach4@example.com',
      :user_image => 'myimage.jpg', :biography => 'asdfa fasdf asf asfd asdf ',
      :password => 'iesha4', :password_confirmation => 'iesha4'
    }
  ]
)

UserRole.destroy_all

UserRole.create(
  [
    { :user_id => 1, :role_id => 1, :is_active =>true },
    { :user_id => 2, :role_id => 2, :is_active =>true },
    { :user_id => 3, :role_id => 3, :is_active =>true },
    { :user_id => 4, :role_id => 2, :is_active =>true }
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
    },
    {
      :category_name => 'Blockchain', :is_active => true
    },
    {
      :category_name => 'Romance', :is_active => true
    },
    {
      :category_name => 'Cooking', :is_active => true
    }
  ]
)
# courses
Course.destroy_all
CourseDetails.destroy_all
id = 0 
20.times do |index|
 id = id + 1
 no_days = Faker::Number.between(5,21)
  Course.create(
    [
      {
        :name => Faker::Lorem.sentence(3,false,0).chop, :description => Faker::Lorem.paragraph,
        :icon => '', :level => Faker::Number.between(1,3),:instructor_id => Faker::Number.between(2,3), :no_days => no_days, :category_id => Faker::Number.between(1,6), :course_image => '',
        :course_thumbnail => '', :is_active => true
      }
    ]
  )

  looper = Faker::Number.between(6,21)
  start = 0
  looper.times do |index|
    start = start + 1 
    rword = Faker::Lorem.word
    CourseDetails.create(
      [
        {
          :day_number => start ,
          :day_topic => Faker::Lorem.sentence(7,false,0), :day_details => Faker::Lorem.paragraph,
          :course_id => id,
          :topic_image => Faker::Avatar.image(rword, "300x300", "jpg"),
          :topic_thumbnail => Faker::Avatar.image(rword, "50x50", "jpg")
        }
      ]
    )
  end

end

# faq
FAQ.destroy_all

20.times do |index|
  FAQ.create(
    [
      {
        :faq_title => Faker::Lorem.question, :faq_description => Faker::Lorem.paragraph
      }
    ]
    )
end

UserEnrollment.destroy_all 
UserEnrollment.create(
  [
    {
      user_id: 3, course_id: Faker::Number.between(1,20), confirmation: 1, notes: Faker::Lorem.sentence(8,false,0), 
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 2, course_id: Faker::Number.between(1,20), confirmation: 1, notes: Faker::Lorem.sentence(8,false,0), 
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 3, course_id: Faker::Number.between(1,20), confirmation: 1, notes: Faker::Lorem.sentence(8,false,0), 
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 2, course_id: Faker::Number.between(1,20), confirmation: 1, notes: Faker::Lorem.sentence(8,false,0), 
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 3, course_id: Faker::Number.between(1,20), confirmation: 1, notes: Faker::Lorem.sentence(8,false,0), 
      start_date:Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    }

  ]
)


