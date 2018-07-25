# course controller
class CourseController < ApplicationController
  # View all courses
  get '/courses' do
    if logged_in?
      @courses = Course.where(is_active: true)
      erb :'/courses/index'
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
  # View course details and the topic assigned
  get '/courses/view/:id' do
    if logged_in?
      @course = find_course(params[:id])
      @coursedetails = CourseDetails.where(course_id: params[:id])
      @userenrolled = UserEnrollment.where(course_id: params[:id], is_active: true)
      erb :'/courses/view_course'
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
  # View course details and administer them by an instructor
  get '/courses/administer/:id' do
    if logged_in?
      if current_user.userrole.role.id == 2
        begin
          @course = find_course(params[:id])
          @coursedetails = CourseDetails.where(course_id: params[:id])
          erb :'/courses/administer_course'
        rescue StandardError => e
          erb :'/users/error', locals: { user: e.message }
        end
      else
        flash[:error] = 'You are not currently logged in!'
        redirect to :'/accessdenied'
      end
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
  # View all courses assigned by an instructor or subscribed by a student
  get '/mycourses' do
    if logged_in?
      if current_user.userrole.role.id == 2
        @courses = Course.where(is_active: true, instructor_id: current_user.id)
        @courses = Course.all.map do |course|
          course.id if course.instructor_id == current_user.id
        end
        @instructor_courses = @courses.compact.map do |c|
          Course.find_by_id(c)
        end
      end
        @subscribed = UserEnrollment.where(user_id: current_user.id).all.map do |userenroll|
          userenroll.course_id if userenroll.user_id == current_user.id
        end
        @student_courses = @subscribed.compact.map do |c|
          Course.find_by_id(c)
        end
      erb :'/courses/mycourses'
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  #  Course Details view
  get '/coursedetail/:detail_id' do

  end

  #  Course Details Add
  get '/coursedetail/:course_id/add' do
    @course = find_course(params[:course_id])
    @coursedetail = CourseDetails.where(course_id: params[:course_id]).order(:day_number).last
    if @coursedetail 
     last_number = @coursedetail.day_number
    else 
      last_number=0
    end 
    loc = { course_id: params[:course_id], action_type: 'Add', last_number: last_number }
    erb :'/courses/course_detail', layout: :layout_admin, locals: loc
  end

  #  Course Details Post Add
  post '/postcoursedetail' do
    ce = params[:action_type]
    if ce == 'Add'
      
    else 

    end 

  end

  #  Course Details Edit
  get '/coursedetail/:course_id/edit/:detail_id' do
    @course = find_course(params[:course_id])
    @coursedetailedit = CourseDetails.where(id: params[:detail_id])
    loc = { course_id: params[:course_id], action_type: 'Edit' }
    erb :'/courses/course_detail.erb', layout: :layout_admin, locals: loc
  end

  
end
