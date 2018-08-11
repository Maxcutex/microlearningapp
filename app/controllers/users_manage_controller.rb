require_relative '../helpers/user_helper'
require_relative '../helpers/ad_user_helper'
# Users Management Controller inheriting from application controller
class UserManageController < ApplicationController
  include UserHelpers
  include AdUserHelpers
  # Only new user will see the signup page
  get '/admin/users' do
    page_title = 'User Management'
    @users = User.all
    erb :'/admin/listusers', locals: {
      page_title: page_title,
      data_table: true
    }
  end

  get '/admin/users/new' do
    page_title = 'User Management - New User'
    erb :'/admin/new_user', locals: {
      page_title: page_title,
      data_table: false
    }
  end

  get '/admin/users/edit/:id' do
    page_title = 'User Management - Edit User'
    @user = User.where(id: params[:id]).first
    erb :'/admin/edit_user', locals: {
      page_title: page_title,
      data_table: false
    }
  end

  post '/processuser' do
    upload_image
    process_new
    save_process_admin
  end

  post '/edituser' do
    upload_image
    process_update(params[:id])
    edit_process_admin
  end
end
