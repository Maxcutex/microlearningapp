require_relative '../helpers/action_helper'
# Users Management Controller inheriting from application controller
class UserManageController < ApplicationController
  include ActionHelpers
  # Only new user will see the signup page
  get '/users' do
    if logged_in?
      if confirm_admin
        page_title = 'User Management'
        @users = User.all
        erb :'/admin/listusers', locals: {
          page_title: page_title,
          data_table: true
        }
      else
        redirect to '/accessdenied'
      end
    else
      redirect to '/login'
    end
  end

  get '/users/new' do
    page_title = 'User Management - New User'
    erb :'/admin/new_user', locals: {
      page_title: page_title,
      data_table: false
    }
  end

  get '/users/edit/:id' do
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
    process_edit
    edit_process_admin
  end
end
