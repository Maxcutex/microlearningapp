require 'spec_helper'

describe CourseController do
  describe 'User View Courses' do
    it 'loads the courses page for a logged in user and view courses' do
      user_values = {
        first_name: 'Nili',
        last_name: 'Ach',
        username: 'nili678',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha', password_confirmation: 'iesha'
      }
      user1 = User.create(user_values)
      user_values2 = {
        first_name: 'Nili2',
        last_name: 'Ach2',
        username: 'nili6782',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha2', password_confirmation: 'iesha2'
      }
      user2 = User.create(user_values2)
      Course.create(
        name: 'Phoenix Fundamentals',
        description: 'Phoenix makes building robust, high-performance web applications easier and more fun than you ever thought possible.',
        icon: '🦅', level: 2, instructor_id: 2, no_days: 10, category_id: 2, course_image: '', course_thumbnail: '', is_active: true
      )
      Course.create(
        name: 'Phoenix Fundamentals 2',
        description: 'Phoenix makes building robust, high-performance web applications easier and more fun than you ever thought possible.',
        icon: '🦅', level: 2, instructor_id: 2, no_days: 10, category_id: 2, course_image: '', course_thumbnail: '', is_active: true
      )
      role1 = Role.create(
        role_name: 'Administrator',
        role_description: 'This is the main role and administrator of the system'
      )
      role2 = Role.create(
        role_name: 'Instructor',
        role_description: 'This is the instructor of the system'
      )
      role3 = Role.create(
        role_name: 'Student',
        role_description: 'This is the student the system'
      )
      UserRole.create(user_id: user1.id, role_id: role3.id, is_active: true)
      UserRole.create(user_id: user2.id, role_id: role2.id, is_active: true)
      UserRole.create(user_id: user1.id, role_id: role1.id, is_active: true)

      visit '/login'
      fill_in(:username, with: 'nili678')
      fill_in(:password, with: 'iesha')
      click_button 'Submit'

      visit '/user/courses'
      # expect(page.status_code).to eq(200)
      expect(page.body).to include('Course')
    end

    it 'does not let a user not logged in to  view the course page' do
      get '/user/courses'
      expect(last_response.location).to include('/login')
    end

    it 'loads the courses page for a subscribed user or courses teaching' do
      user_values = {
        first_name: 'Nili',
        last_name: 'Ach',
        username: 'nili678',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha', password_confirmation: 'iesha'
      }
      user1 = User.create(user_values)
      user_values2 = {
        first_name: 'Nili2',
        last_name: 'Ach2',
        username: 'nili6782',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha2', password_confirmation: 'iesha2'
      }
      user2 = User.create(user_values2)
      Course.create(
        name: 'Phoenix Fundamentals',
        description: 'Phoenix makes building robust, high-performance web applications easier and more fun than you ever thought possible.',
        icon: '🦅', level: 2, instructor_id: 2, no_days: 10, category_id: 2, course_image: '', course_thumbnail: '', is_active: true
      )
      Course.create(
        name: 'Phoenix Fundamentals 2',
        description: 'Phoenix makes building robust, high-performance web applications easier and more fun than you ever thought possible.',
        icon: '🦅', level: 2, instructor_id: 2, no_days: 10, category_id: 2, course_image: '', course_thumbnail: '', is_active: true
      )
      role1 = Role.create(
        role_name: 'Administrator',
        role_description: 'This is the main role and administrator of the system'
      )
      role2 = Role.create(
        role_name: 'Instructor',
        role_description: 'This is the instructor of the system'
      )
      role3 = Role.create(
        role_name: 'Student',
        role_description: 'This is the student the system'
      )
      UserRole.create(user_id: user1.id, role_id: role3.id, is_active: true)
      UserRole.create(user_id: user2.id, role_id: role2.id, is_active: true)
      UserRole.create(user_id: user1.id, role_id: role1.id, is_active: true)
      visit '/login'
      fill_in(:username, with: 'nili678')
      fill_in(:password, with: 'iesha')
      click_button 'Submit'
      visit '/user/mycourses'
      expect(page.status_code).to eq(200)
    end

    it 'let an instructor to create a new course' do
    end
  end
end
