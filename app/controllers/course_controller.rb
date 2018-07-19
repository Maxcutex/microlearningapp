# course controller
class CourseController < ApplicationController
  # View all courses
  get '/courses' do
    if logged_in?
      @courses = Course.all
      erb :'/courses/index'
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
end
