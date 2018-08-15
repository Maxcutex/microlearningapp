require 'spec_helper'

describe UserController do
  describe 'CREATE action' do
    context 'Create new user' do
      it 'loads the user signup page' do
        get '/signup'
        expect(last_response.status).to eq(200)
      end
      it 'does not let a user sign up without a first_name' do
        params = {
          first_name: '',
          last_name: 'andrian',
          username: 'adri123',
          email: 'adri@example.com',
          
          biography: 'asdfa fasdf asf asfd asdf ',
          password: 'stellenbosch',
          password_confirmation: 'stellenbosch', is_active: true
        }
        xvar = { user: params }
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without a last_name' do
        params = {
          first_name: 'andrian',
          last_name: '',
          username: 'adri123',
          email: 'adri@example.com',
          
          biography: 'asdfa fasdf asf asfd asdf ',
          password: 'stellenbosch',
          password_confirmation: 'stellenbosch', is_active: true
        }
        xvar = { user: params }
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without a username' do
        params = {
          first_name: '',
          last_name: 'andrian',
          username: '',
          email: 'adri@example.com',
          
          biography: 'asdfa fasdf asf asfd asdf ',
          password: 'stellenbosch',
          password_confirmation: 'stellenbosch', is_active: true
        }
        xvar = { user: params }
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without an email' do
        params = {
          first_name: '',
          last_name: 'andrian',
          username: 'adri123',
          email: '',
          
          biography: 'asdfa fasdf asf asfd asdf ',
          password: 'stellenbosch',
          password_confirmation: 'stellenbosch', is_active: true
        }
        xvar = { user: params }
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end

      it 'does not let a user sign up without a password' do
        params = {
          first_name: '',
          last_name: 'andrian',
          username: 'adri123',
          email: 'adri@example.com',
          
          biography: 'asdfa fasdf asf asfd asdf ',
          password: '',
          password_confirmation: 'stellenbosch', is_active: true
        }
        xvar = { user: params }
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
     
      it 'does not let a logged in user view the signup page' do
        user_values = {
          first_name: 'Nili', last_name: 'Ach', username: 'nili678',
          email: 'niliach@example.com',
          biography: 'asdfa fasdf asf asfd asdf ', password: 'iesha',
          password_confirmation: 'iesha', is_active:true
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
        session[:role_name] = roles1.role_name
        get '/signup'
        expect(last_response.location).to include('/user/dashboard')
      end
    end
  end
end
