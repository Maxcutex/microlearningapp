require './config/environment'
require 'sinatra/base'
require 'haml'
require 'base64'
require_relative '../helpers/session_helper'
require_relative '../helpers/application_helper'

# Main Controller for the microlearning application
class ApplicationController < Sinatra::Base
  helpers Sinatra::AppHelpers
  include SessionHelpers
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

  # User will only see homepage IF they are not currently logged in
  get '/' do
    if logged_in?
      redirect to '/courses'
    else
      @page_title = 'Welcome to Asentus Course Management'
      erb :index, layout: :layout_web, locals: { page_title: @page_title }
    end
  end
end
