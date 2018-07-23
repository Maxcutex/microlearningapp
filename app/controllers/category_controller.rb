# Category Controller for managing category of courses
class CategoryController < ApplicationController
  # View all courses
  get '/managecategories' do
    if logged_in?
        begin
            if is_admin?
              @categories = CourseCategory.all
              erb :'/courses/managecategories' , :layout => :layout_admin_pages
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
end 