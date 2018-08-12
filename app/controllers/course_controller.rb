require_relative '../helpers/user_helper'
require_relative '../helpers/course_helper'
# course controller
class CourseController < ApplicationController
  include CourseHelpers
  @page_title = ''
  get '/instructor/managecourses' do
      @courses = Course.all_courses
      erb :'/courses/managecourse', locals: {
        page_title: 'Manage Categories', data_table: false
      }
  end

  get '/instructor/managecourses/:id' do
    begin
      @course = find_course(params[:id]) if params[:id]
      @categories = CourseCategory.all
      loc = { course_id: @course ? @course.id : nil, page_title: 'Manage Courses', data_table: false }
      erb :'/courses/managecourse_edit', layout: :layout_admin, locals: loc
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: {
        user: 'Error:' + e.message,
        page_title: 'Error',
        data_table: false
      }
    end
  end

  post '/postcourse' do
    begin
      parameters = process_file_parameters
      if params[:action_type] == 'Add'
        @course = Course.create(parameters)
      else
        @course = find_course(params[:id]) if params[:id]
        @course.update(parameters)
      end
      save_and_redirect
    rescue StandardError => e
      erb :'/users/error', locals: {
        user: e.message, page_title: 'Error', data_table: false
      }
    end
  end

  # View all courses
  get '/user/courses' do
    @courses = Course.active_courses
    @user_enrolled = UserEnrollment.active_user_enrollment(session[:user_id])
    erb :'/courses/index', locals: {
      page_title: 'Courses', data_table: true
    }
  end

  # View course details and the topic assigned
  get '/user/courses/:id/enroll' do
    @course = find_course(params[:id])
    @user_enrolled = UserEnrollment.get_active_enrollment(session[:user_id], @course.id)
    erb :'/courses/register_course', layout: :layout_admin, locals: {
      page_title: 'Courses', data_table: false
    }
  end

  # post enrollment for user
  post '/courses/:id/postenroll' do
    initialize_course_post
    if @user_enroll.save
      construct_new_course_mail_send
      construct_instructor_course_mail_send
      redirect to '/user/courses'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      erb :'/users/error', locals: {
        user: 'Error:' + @user_enroll.errors.full_messages
      }
    end
  end

  get '/user/courses/:course_id/unsubscribe' do
    process_unsubscribe(params[:course_id], session[:user_id])
  end

  # View course details and the topic assigned
  get '/user/courses/view/:id' do
    @course = find_course(params[:id])
    @course_details = CourseDetail.course_details_by_course_id(params[:id])
    @user_enrolled = UserEnrollment.get_active_enrollment(params[:id], session[:user_id])
    erb :'/courses/view_course', locals: {
      page_title: 'My Courses', data_table: false
    }
  end

  # View all courses  subscribed by a student
  get '/user/mycourses' do
    @subscribed = UserEnrollment.get_by_user_id(current_user.id).all.map do |user_enroll|
      user_enroll.course_id if user_enroll.user_id == current_user.id
    end
    @student_courses = @subscribed.compact.map do |c|
      Course.find_by_id(c)
    end
    erb :'/courses/mycourses', locals: {
      page_title: 'My Courses', data_table: false
    }
  end

  # View all courses assigned by an instructor or subscribed by a student
  get '/instructor/mycourses' do
    @courses = Course.active_course_by_instructor(current_user.id)
    @courses = Course.all.map do |course|
      course.id if course.instructor_id == current_user.id
    end
    @instructor_courses = @courses.compact.map do |c|
      Course.find_by_id(c)
    end
    @subscribed = UserEnrollment.get_by_user_id(current_user.id).all.map do |user_enroll|
      user_enroll.course_id if user_enroll.user_id == current_user.id
    end
    @student_courses = @subscribed.compact.map do |c|
      Course.find_by_id(c)
    end
    erb :'/courses/mycourses', locals: {
      page_title: 'My Courses', data_table: false
    }
  end
end
