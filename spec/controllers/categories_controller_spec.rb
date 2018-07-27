require 'spec_helper'

describe CategoryController do
  describe 'Admin Manage Courses' do
    it 'lets an administraator create a category for courses' do
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
      UserRole.create(user_id: user.id, role_id: roles1.id, is_active: true)
      CourseCategory.create(
        category_name: 'My Category1',
        is_active: true
      )
      visit '/login'
      fill_in(:username, with: 'nili678')
      fill_in(:password, with: 'iesha')
      click_button 'Submit'

      visit '/managecategories'
      fill_in(:category_name, with: 'My Category')
      click_button 'Submit'
    end
  end
end
