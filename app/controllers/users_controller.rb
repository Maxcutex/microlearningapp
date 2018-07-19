# Users Controller inheriting from application controller
class UserController < ApplicationController
  # Only new user will see the signup page
  get '/signup' do
    if logged_in?
      redirect to '/courses'
    else
      page_title = 'Register For Course'
      class_title = 'register-page'
      erb :'/users/new', :layout => :layout_login_reg, :locals => { :page_title => page_title, :class_title => class_title }
    end
  end

  # CREATE a new user based on form information
  post '/signup' do
    postuser = params[:user]
    @user = User.new(postuser)
    @user.instructor = false
    if params[:user]['image']
      file = params[:user]['image']
      file_name = file[:filename]
      temp_file = file[:tempfile]

      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end

      postuser['image'] = file_name
    end
    if @user.save
      session[:user_id] = @user.id
      redirect to '/courses'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      redirect to '/signup'
    end
  end

  # User currently logged in will view the Courses page directly
  get '/login' do
    if logged_in?
      redirect to '/courses'
    else
      page_title = 'Login To App'
      class_title = 'login-page'
      erb :'/users/login', :layout => :layout_login_reg, :locals => { :page_title => page_title, :class_title => class_title }
    end
  end

  # Verify user information to Log In
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/courses'
    else
      flash[:error] = 'Sorry, invalid username and password.'
      redirect to '/login'
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
      erb :'/users/index'
    else
      redirect to '/'
    end
  end
end
