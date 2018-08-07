require 'spec_helper'

describe UserController do
  describe 'Login' do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads the login page and shows link for registration' do
      get '/login'
      expect(last_response.body).to include('Register a new membership')
    end

    it 'loads the login page and redirects to registration' do
      visit '/login'
      click_link('Register a new membership')
      expect(current_path).to eq('/signup')
    end
  end
  describe 'Logout' do
    it 'let a logged in user logout' do
      session = {}
      session[:user_id] = 1
      get '/logout'
      expect(last_response.location).to include('/')
    end

    it 'does not let a user logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include('/')
    end
  end
end
