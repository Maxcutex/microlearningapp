require 'spec_helper'

describe CourseController do
  describe "User View Courses" do
    it 'loads the courses page for a logged in user and view courses' do
    user_values = { 
      :first_name => 'Nili',
      :last_name => 'Ach',
      :username => 'nili678',
      :email => 'niliach@example.com',
      :user_image =>'myimage.jpg', :biography =>'asdfa fasdf asf asfd asdf ', 
      :password => 'iesha', :password_confirmation => 'iesha' 
    }
      user = User.create(user_values)
      course1 = Course.create(name: "Phoenix Fundamentals", 
      description: "Phoenix makes building robust, high-performance web applications easier and more fun than you ever thought possible.", 
      icon: "🦅", level: 2, instructor_id: 1, no_days:10, category_id:2,course_image:'', course_thumbnail:'', is_active: true)
        
      visit '/login'
      fill_in(:username, :with => "nili678")
      fill_in(:password, :with => "iesha")
      click_button 'Submit'

      visit "/courses"
      expect(page.status_code).to eq(200)
    end    

    it 'does not let a user not logged in to  view the course page' do
      get '/courses'
      expect(last_response.location).to include("/login")
    end
  end 
end
