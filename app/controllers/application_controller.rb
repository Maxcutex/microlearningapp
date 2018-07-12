require './config/environment'

class ApplicationController < Sinatra::Base
    
  configure do
    register Sinatra::ActiveRecordExtension
    enable :sessions
    use Rack::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end
  before do
        headers 'Content-Type' => 'text/html; charset=utf-8'
  end
end 