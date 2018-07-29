require 'spec_helper'

describe BackEndManageController do
  describe 'Admin Manage Courses' do
    it 'loads the manage courses page for a logged in an admin' do
      user_values = {
        first_name: 'Nili',
        last_name: 'Ach',
        username: 'nili678',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha', password_confirmation: 'iesha'
      }
      user = User.create(user_values)

      roles1 = Role.create(
        role_name: 'Administrator',
        role_description: 'Administrator on the system'
      )
      roles2 = Role.create(
        role_name: 'Instructor',
        role_description: 'Administrator on the system'
      )

      UserRole.create(user_id: user.id, role_id: roles2.id, is_active: true)
      visit '/login'
      fill_in(:username, with: 'nili678')
      fill_in(:password, with: 'iesha')
      click_button 'Submit'

      visit '/managecourses'
      expect(page.status_code).to eq(200)
    end

    it 'does not let a non admin user to view manage courses' do
      user_values = {
        first_name: 'Nili', last_name: 'Ach', username: 'nili678',
        email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
        password: 'iesha', password_confirmation: 'iesha'
      }
      user = User.create(user_values)
      roles1 = Role.create(
        role_name: 'Administrator',
        role_description: 'Administrator on the system'
      )
      UserRole.create(user_id: user.id, role_id: roles1.id, is_active: true)
      params = {
        username: 'nili678',
        password: 'iesha'
      }
      post '/login', params
      session = {}
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include('/dashboard')
    end
  end
end
