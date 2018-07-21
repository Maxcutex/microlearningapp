# course controller
class CourseController < ApplicationController
  # View all courses
  get '/courses' do
    if logged_in?
      @courses = Course.where(is_active: true)
      erb :'/courses/index', :layout => :layout_admin
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
  
end
