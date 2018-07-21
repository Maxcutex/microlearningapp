require 'spec_helper'
describe ApplicationController do
  describe 'HomePage' do
    it 'loads the homepage if user is not logged in' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('One-Stop Learning App')
    end
  end
end
