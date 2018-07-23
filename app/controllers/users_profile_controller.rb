# Users Profile Controller inheriting from application controller
class UserProfileController < ApplicationController
  # Only new user will see the signup page
  get '/profile' do
    if logged_in?
      page_title = 'Profile Management'

      erb :'/users/profile', :locals => { :page_title => page_title }  
    else
      redirect to '/dashboard'
    end
  end

  post '/editprofile' do
    file_name = ''
    begin
      if params[:user_image]
        file = params[:user_image]
        file_name = file[:filename]
        temp_file = file[:tempfile]

        File.open("./public/images/#{file_name}", 'wb') do |f|
          f.write(temp_file.read)
        end
      end
      @user_update = User.find_by_id(session[:user_id])
      @user_update.user_image = file_name
      updated_values = {}
      if file_name==''
        updated_values = { 
        first_name: params[:first_name],
        last_name: params[:last_name],
        biography: params[:biography]
      }
      else
        updated_values = { 
        user_image: file_name, 
        first_name: params[:first_name],
        last_name: params[:last_name],
        biography: params[:biography]
      }
    end
    
    @user_update.update(updated_values)
    redirect to '/profile'
    rescue Exception => e
        
    end 
  end 
end