require 'spec_helper'

describe UserController do
  describe 'Login' do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'does not let a logged in user view the login page' do
      user_values = {
        first_name: 'Nili', last_name: 'Ach', username: 'nili678', email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ', password: 'iesha',
        password_confirmation: 'iesha'
      }
      user = User.create(user_values)
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
  describe 'Logout' do
    it 'let a logged in user logout' do
      user_values = {
        first_name: 'Nili', last_name: 'Ach', username: 'nili678', email: 'niliach@example.com',
        user_image: 'myimage.jpg', biography: 'asdfa fasdf asf asfd asdf ', password: 'iesha',
        password_confirmation: 'iesha'
      }
      User.create(user_values)
      params = {
        username: 'nili678',
        password: 'iesha'
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include('/login')
    end

    it 'does not let a user logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include('/')
    end
  end
end
