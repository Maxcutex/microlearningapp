# admin manage controller
class BackEndManageController < ApplicationController
  get '/managecourses' do
    if logged_in?
      begin
        if is_admin?
          @courses = Course.all
          erb :'/courses/managecourse' , :layout => :layout_admin
        else
          flash[:error] = 'You are not currently logged in!'
          redirect to :'/accessdenied'
        end
      rescue Exception =>e
         erb :'/users/error', :locals=> { user: e.message }
      end 
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  get '/accessdenied' do
    erb :'/admin/accessdenied' , :layout => :layout_admin
  end
end