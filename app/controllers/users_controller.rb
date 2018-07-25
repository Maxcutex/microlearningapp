# Users Controller inheriting from application controller
class UserController < ApplicationController
  # Only new user will see the signup page
  get '/signup' do
    if logged_in?
      redirect to '/dashboard'
    else
      page_title = 'Register For Course'
      class_title = 'register-page'
      loc = { page_title: page_title, class_title: class_title }
      erb :'/users/new', layout: :layout_login_reg, locals: loc
    end
  end

  # CREATE a new user based on form information
  post '/signup' do
    postuser = params[:user]
    @user = User.new(postuser)
    @user.user_image = ''
    # if params[:user]['user_image']
    #   file = params[:user]['user_image']
    #   file_name = file[:filename]
    #   temp_file = file[:tempfile]

    #   File.open("./public/images/#{file_name}", 'wb') do |f|
    #     f.write(temp_file.read)
    #   end

    #   @user.user_image = file_name
    # end
    if @user.save
      session[:user_id] = @user.id
      redirect to '/dashboard'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      redirect to '/signup'
      # erb :'/users/error', :locals=> { user: @user.errors.full_messages }
    end
  end

  # User currently logged in will view the dashboard
  get '/login' do
    if logged_in?
      redirect to '/dashboard'
    else
      local_values = { page_title: 'Login To App', class_title: 'login-page' }
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
      flash[:message] = 'You have logged out successfully!'
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  # Dashboard View
  get '/dashboard' do
    if logged_in?
      erb :'/users/index', layout: :layout_admin
    else
      redirect to '/login'
    end
  end
end
