require_relative '../spec_helper'
require_relative '../../app/controllers/users_controller.rb'

describe UserController do
  it 'should display hello world' do
    params = { 'user' => { 'first_name' => 'Kate', 'last_name' => 'David' } }
    post '/signup', params
      follow_redirect!
      assert last_response.body.include?('Dashboard')
  end
end
