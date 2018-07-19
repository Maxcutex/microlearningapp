require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage if user is not logged in' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('One-Stop Learning App')
    end
  end

  describe "Login" do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'does not let a logged in user view the login page' do
      user_values = { :first_name => "Nili", :last_name => "Ach", :username => "nili678",:email => "niliach@example.com", 
        :user_image =>'myimage.jpg' ,:biography =>'asdfa fasdf asf asfd asdf ' , :password => "iesha", :password_confirmation => "iesha" }
      user = User.create(user_values)
      params = {
        :username => "nili678",
        :password => "iesha"
      }
      post '/login', params
      session = {}
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include("/dashboard")
    end
  end
end