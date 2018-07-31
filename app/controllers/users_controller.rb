require_relative '../helpers/action_helper'
# Users Controller inheriting from application controller
class UserController < ApplicationController
  include ActionHelpers
  @page_title = 'Register for Course'
  # Only new user will see the signup page
  get '/signup' do
    if logged_in?
      redirect to '/dashboard'
    else
      class_title = 'register-page'
      loc = { page_title: @page_title, class_title: class_title, data_table: false }
      erb :'/users/new', layout: :layout_login_reg, locals: loc
    end
  end

  # CREATE a new user based on form information
  post '/signup' do
    set_session_create_values
    upload_image
    process_new
    save_process('Add', '/dashboard', '/signup')
  end

  # User currently logged in will view the dashboard
  get '/login' do
    if logged_in?
      redirect to '/dashboard'
    else
      local_values = { page_title: 'Login To App', class_title: 'login-page', data_table: false }
      erb :'/users/login', layout: :layout_login_reg, locals: local_values
    end
  end

  # Verify user information to Log In
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/dashboard'
    else
      flash[:error] = 'Sorry, invalid username and password.'
      redirect to '/login'
      # erb :'/users/error', :locals=> { user: @user.errors.full_messages }
    end
  end

  # Log Out process
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  # Dashboard View
  get '/dashboard' do
    if logged_in?
      erb :'/users/index', layout: :layout_admin, locals: { page_title: 'Dashboard', data_table: false }
    else
      redirect to '/login'
    end
  end
end
