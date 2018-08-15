require 'faker'

Role.destroy_all
Role.create(
  [
    {
      role_name: 'Administrator',
      role_description: 'This is the main role and administrator of the system'
    },
    {
      role_name: 'Instructor',
      role_description: 'This is the owner of courses and can add/delete topics'
    },
    {
      role_name: 'Student',
      role_description: 'This is user of the application'
    }
  ]
)

User.destroy_all

User.create(
  [
    {
      first_name: 'Nili', last_name: 'Ach1', username: 'nili678',
      email: 'niliach1@example.com',
      biography: 'asdfa fasdf asf asfd asdf ',
      password: 'iesha1', password_confirmation: 'iesha1', is_active: true,
      created_at: DateTime.now, updated_at: DateTime.now
    },
    {
      first_name: 'David', last_name: 'Plate', username: 'nili6782',
      email: 'niliach2@example.com',
      biography: 'asdfa fasdf asf asfd asdf ',
      password: 'iesha2', password_confirmation: 'iesha2', is_active: true,
      created_at: DateTime.now, updated_at: DateTime.now
    },
    {
      first_name: 'Femi', last_name: 'Lanre', username: 'nili6783',
      email: 'niliach3@example.com',
      biography: 'asdfa fasdf asf asfd asdf ',
      password: 'iesha3', password_confirmation: 'iesha3', is_active: true,
      created_at: DateTime.now, updated_at: DateTime.now
    },
    {
      first_name: 'Jay', last_name: 'Bassey', username: 'nili6784',
      email: 'ennyboy@gmail.com',
      biography: 'asdfa fasdf asf asfd asdf ',
      password: 'iesha4', password_confirmation: 'iesha4', is_active: true,
      created_at: DateTime.now, updated_at: DateTime.now
    },
    {
      first_name: 'Eno', last_name: 'Bassey', username: 'eno.bassey',
      email: 'eno.bassey@andela.com',
      biography: 'asdfa fasdf asf asfd asdf ',
      password: 'iesha5', password_confirmation: 'iesha5', is_active: true,
      created_at: DateTime.now, updated_at: DateTime.now
    }
  ]
)

UserRole.destroy_all

UserRole.create(
  [
    { user_id: 1, role_id: 1, is_active: true },
    { user_id: 2, role_id: 2, is_active: true },
    { user_id: 3, role_id: 2, is_active: true },
    { user_id: 4, role_id: 3, is_active: true },
    { user_id: 5, role_id: 3, is_active: true }
  ]
)

# course categories
CourseCategory.destroy_all

CourseCategory.create(
  [
    {
      category_name: 'Education', is_active: true
    },
    {
      category_name: 'Technology', is_active: true
    },
    {
      category_name: 'Political', is_active: true
    },
    {
      category_name: 'Blockchain', is_active: true
    },
    {
      category_name: 'Romance', is_active: true
    },
    {
      category_name: 'Cooking', is_active: true
    }
  ]
)
# courses
Course.destroy_all
CourseDetail.destroy_all
id = 0
20.times do
  id += 1
  no_days = Faker::Number.between(5, 21)
  Course.create(
    [
      {
        name: Faker::Lorem.sentence(3, false, 0).chop,
        description: Faker::Lorem.paragraph,
        icon: '', level: Faker::Number.between(1, 3),
        instructor_id: Faker::Number.between(2, 3),
        no_days: no_days,
        category_id: Faker::Number.between(1, 6), is_active: true
      }
    ]
  )

  looper = Faker::Number.between(6, 21)
  start = 0
  looper.times do
    start += 1
    rword = Faker::Lorem.word
    CourseDetail.create(
      [
        {
          day_number: start,
          day_topic: Faker::Lorem.sentence(7, false, 0),
          day_details: Faker::Lorem.paragraph,
          course_id: id
        }
      ]
    )
  end
end

# faq
FAQ.destroy_all

20.times do
  FAQ.create(
    [
      {
        faq_title: Faker::Lorem.question, faq_description: Faker::Lorem.paragraph
      }
    ]
  )
end

UserEnrollment.destroy_all
UserEnrollment.create(
  [
    {
      user_id: 4, course_id: Faker::Number.between(1, 20), confirmation: 1, notes: Faker::Lorem.sentence(8, false, 0),
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 5, course_id: Faker::Number.between(1, 20), confirmation: 1, notes: Faker::Lorem.sentence(8, false, 0),
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 4, course_id: Faker::Number.between(1, 20), confirmation: 1, notes: Faker::Lorem.sentence(8, false, 0),
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 5, course_id: Faker::Number.between(1, 20), confirmation: 1, notes: Faker::Lorem.sentence(8, false, 0),
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    },
    {
      user_id: 4, course_id: Faker::Number.between(1, 20), confirmation: 1, notes: Faker::Lorem.sentence(8, false, 0),
      start_date: Faker::Date.between(2.days.ago, Date.today),
      end_date: Faker::Date.forward(21), is_active: true
    }

  ]
)
