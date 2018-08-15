require './config/environment'
require 'sinatra/base'
require 'base64'
require_relative '../helpers/session_helper'
require_relative '../mailers/mail_sender'
require_relative '../helpers/application_helper'

# Main Controller for the microlearning application
class ApplicationController < Sinatra::Base
  helpers Sinatra::AppHelpers
  include SessionHelpers
  include MailSender
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

  before '/admin/*' do
    check_logged_in
    check_if_admin
  end

  before '/instructor/*' do
    check_logged_in
    check_if_instructor
  end

  before '/user/*' do
    check_logged_in
  end

  def check_logged_in
    unless logged_in?
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  def check_if_instructor
    unless instructor?
      flash[:error] = 'You do not have access to this page!'
      redirect to :'/accessdenied'
    end
  end

  def check_if_admin
    unless admin?
      flash[:error] = 'You do not have access to this page!'
      redirect to :'/accessdenied'
    end
  end

  # User will only see homepage IF they are not currently logged in
  get '/' do
    if logged_in?
      redirect to '/user/courses'
    else
      @page_title = 'Welcome to Asentus Course Management'
      erb :index, layout: :layout_web, locals: { page_title: @page_title }
    end
  end
end
