require_relative '../helpers/action_helper'
# Users Profile Controller inheriting from application controller
class UserProfileController < ApplicationController
  include ActionHelpers
  @page_title = 'Profile Management'
  # Only new user will see the signup page
  get '/profile' do
    if logged_in?
      erb :'/users/profile', locals: { page_title: @page_title, data_table: false }
    else
      redirect to '/dashboard'
    end
  end

  post '/editprofile' do
    begin
      params[:user][:is_active] = true
      upload_image
      process_update(session[:user_id])
      save_process
    rescue StandardError => e
      erb :'/users/error', locals: { user: e.message, page_title: 'Error', data_table: false }
    end
  end
end
