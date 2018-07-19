require_relative '../spec_helper'
# require_relative '../../app/controllers/application_controller.rb'

describe 'testing home page' do
  it 'should display hello world' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Learning One Step At a Time')
  end
end

describe 'hello world' do
  it 'says hello' do
    get '/'
    expect(last_response).to be_ok
  end
end
