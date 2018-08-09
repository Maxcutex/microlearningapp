require 'spec_helper'
require 'pry'

describe UserProfileController do
  describe 'VIEW action' do
    context 'View user profile' do
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
        visit '/login'
        fill_in(:username, with: 'nili678')
        fill_in(:password, with: 'iesha')
        click_button 'Submit'
        session = {}
        session[:user_id] = user.id
        visit '/user/profile'
        expect(page.body).to include('Nili Ach')
      end
    end
  end
  describe 'Edit action' do
    context 'Edit user profile' do
      it 'let a logged in user see a section to update their own information' do
        user_values = {
          first_name: 'Nili',
          last_name: 'Ach',
          username: 'nili678',
          email: 'niliach@example.com',
          user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ',
          password: 'iesha', password_confirmation: 'iesha'
        }
        user = User.create(user_values)
        visit '/login'
        fill_in(:username, with: 'nili678')
        fill_in(:password, with: 'iesha')
        click_button 'Submit'
        session = {}
        session[:user_id] = user.id
        visit '/user/profile'
        expect(page.body).to include('User Profile')
        expect(page.body).to include('Nili Ach')
        expect(page.body).to include('Edit Profile')
      end

      it 'let a logged in user to update their own information' do
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
        visit '/login'
        fill_in(:username, with: 'nili678')
        fill_in(:password, with: 'iesha')
        click_button 'Submit'
        session = {}
        session[:user_id] = user.id

        visit '/user/profile'
        expect(page.body).to include('User Profile')
        expect(page.body).to include('Nili Ach')
        expect(page.body).to include('Edit Profile')

        fill_in :first_name, with: 'Editedfirstname'
        fill_in :last_name, with: 'editedlastname'
        attach_file('Image Upload', 'spec/uploads/him.jpg')
        click_button 'Submit'
      end
    end
  end
end
