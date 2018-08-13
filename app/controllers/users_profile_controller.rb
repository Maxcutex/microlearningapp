require_relative '../helpers/user_helper'
# Users Profile Controller inheriting from application controller
class UserProfileController < ApplicationController
  include UserHelpers
  @page_title = 'Profile Management'
  # Only new user will see the signup page
  get '/user/profile' do
    erb :'/users/profile', layout: :layout_admin, locals: { page_title: @page_title, data_table: false }
  end

  post '/user/editprofile' do
    params[:user][:is_active] = true
    upload_image
    process_update(session[:user_id])
    save_process('Edit', '/user/profile', '/user/profile')
  end
end
