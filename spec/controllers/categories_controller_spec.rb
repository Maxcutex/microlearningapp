require 'spec_helper'

describe CategoryController do
  describe 'Admin Manage Courses' do
    it 'lets an administrator create a category for courses', :js do
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

      visit '/admin/managecategories/new'
      fill_in(:category_name, with: 'My Category')
      check 'is_active'
      click_button 'Submit'

      expect(current_path).to eq('/admin/managecategories')
    end
  end
end
