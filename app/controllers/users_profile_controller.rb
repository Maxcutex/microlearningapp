# Users Profile Controller inheriting from application controller
class UserProfileController < ApplicationController
  # Only new user will see the signup page
  get '/profile' do
    if logged_in?
      page_title = 'Profile Management'

      erb :'/users/profile', :layout => :layout_admin_pages, :locals => { :page_title => page_title }  
    else
      redirect to '/dashboard'
    end
  end

  post '/editprofile' do
    userval = params[:user]
    file_name = ''
    begin
    if params[:user]['user_image']
      file = params[:user]['user_image']
      file_name = file[:filename]
      temp_file = file[:tempfile]

      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end
    end
    @user_update = User.find_by_id(session[:user_id])
    @user_update.user_image = file_name
    updated_values = { 
        user_image: file_name, 
        first_name: userval[:first_name],
        last_name: userval[:last_name],
        username: userval[:username],
        email: userval[:email],
        biography: userval[:biography]
    }
    @user_update.update(updated_values)
    redirect to '/profile'
    rescue Exception => e
        
    end 
  end 
end