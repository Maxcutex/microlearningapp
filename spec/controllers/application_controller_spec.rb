require_relative '../spec_helper'
require_relative '../../app/controllers/application_controller.rb'

describe ApplicationController do
  it 'should display hello world' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Hello world')
  end
end

describe 'hello world' do
  it 'says hellow' do
    get '/'
    expect(last_response).to be_ok
  end

end