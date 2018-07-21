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
          :first_name => '',
          :last_name => 'andrian',
          :username => 'adri123',
          :email => 'adri@example.com',
          :user_image =>'myimage.jpg',
          :biography =>'asdfa fasdf asf asfd asdf ',
          :password => 'stellenbosch', 
          :password_confirmation => 'stellenbosch'
        }
        xvar = { :user => params}
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without a last_name' do
        params = {
          :first_name => 'andrian',
          :last_name => '',
          :username => 'adri123',
          :email => 'adri@example.com',
          :user_image =>'myimage.jpg',
          :biography =>'asdfa fasdf asf asfd asdf ',
          :password => 'stellenbosch', 
          :password_confirmation => 'stellenbosch'
        }
        post '/signup', params
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without a username' do
        params = {
          :first_name => '',
          :last_name => 'andrian',
          :username => '',
          :email => 'adri@example.com',
          :user_image =>'myimage.jpg',
          :biography =>'asdfa fasdf asf asfd asdf ',
          :password => 'stellenbosch',
          :password_confirmation => 'stellenbosch'
        }
        xvar = { :user => params}
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'does not let a user sign up without an email' do
        params = {
          :first_name => '',
          :last_name => 'andrian',
          :username => 'adri123',
          :email => '',
          :user_image =>'myimage.jpg',
          :biography =>'asdfa fasdf asf asfd asdf ',
          :password => 'stellenbosch',
          :password_confirmation => 'stellenbosch'
        }
        xvar = { :user => params}
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end  
      it 'does not let a user sign up without a password' do
        params = {
          :first_name => '',
          :last_name => 'andrian',
          :username => 'adri123',
          :email => 'adri@example.com',
          :user_image =>'myimage.jpg',
          :biography =>'asdfa fasdf asf asfd asdf ',
          :password => '',
          :password_confirmation => 'stellenbosch'
        }
        xvar = { :user => params}
        post '/signup', xvar
        expect(last_response.location).to include('/signup')
      end
      it 'signup directs user to dashboard index page' do
        user_values = { :first_name => 'Nili', :last_name => 'Ach', :username => 'nili678',:email => 'niliach@example.com',
            :user_image =>'myimage.jpg', :biography =>'asdfa fasdf asf asfd asdf ', :password => 'iesha', :password_confirmation => 'iesha' }
        params = {}
        params[:user] = user_values
        post '/signup', params
        expect(last_response.location).to include('/dashboard')
      end
      it 'does not let a logged in user view the signup page' do
        user_values = { :first_name => 'Nili', :last_name => 'Ach', :username => 'nili678',
          :email => 'niliach@example.com',
          :user_image =>'myimage.jpg', :biography =>'asdfa fasdf asf asfd asdf ', :password => 'iesha', :password_confirmation => 'iesha' }
        user = User.create(user_values)
        params = {
          :username => 'nili678',
          :password => 'iesha'
        }
        post '/login', params
        session = {}
        session[:user_id] = user.id
        get '/signup'
        expect(last_response.location).to include('/dashboard')
      end
    end
  end
end
