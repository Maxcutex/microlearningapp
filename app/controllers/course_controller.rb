require_relative '../helpers/user_helper'
# course controller
class CourseController < ApplicationController
  @page_title = ''

  get '/instructor/managecourses' do
    begin
      @courses = Course.all_courses
      erb :'/courses/managecourse', locals: {
        page_title: 'Manage Categories', data_table: false
      }
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error', data_table: false
      }
    end
  end

  get '/instructor/managecourses/:id' do
    begin
      @course = find_course(params[:id]) if params[:id]
      @categories = CourseCategory.all
      loc = { course_id: @course ? @course.id : nil, page_title: 'Manage Categories', data_table: false }
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
    file_name = ''
    begin
      if params[:course_image]
        file = params[:course_image]
        file_name = file[:filename]
        temp_file = file[:tempfile]
        File.open("./public/images/#{file_name}", 'wb') do |f|
          f.write(temp_file.read)
        end
      end
      parameters = {
        name: params[:course_name],
        description: params[:course_description],
        is_active: params[:is_active],
        icon: '',
        instructor_id: session[:user_id],
        no_days: params[:course_days],
        category_id: params[:course_category],
        level: params[:course_level],
        course_image: file_name
      }
      if params[:action_type] == 'Add'
        @course = Course.create(parameters)
      else
        @course = find_course(params[:id]) if params[:id]
        @course.update(vari)
      end
      if @course.save
        redirect to '/managecourses'
      else
        flash[:error] = 'Kindly fill in all required fields correctly!'
        erb :'/users/error', locals: {
          user: 'Error:' + @course.errors.full_messages, page_title: 'Error',
          data_table: false
        }
      end
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: {
        user: 'Error:' + e.message, page_title: 'Error', data_table: false
      }
    rescue StandardError => e
      erb :'/users/error', locals: {
        user: e.message, page_title: 'Error', data_table: false
      }
    end
  end

  # View all courses
  get '/user/courses' do
    @courses = Course.where(is_active: true)
    @user_enrolled = UserEnrollment.where(
      is_active: true,
      user_id: session[:user_id]
    )
    erb :'/courses/index', locals: {
      page_title: 'Courses', data_table: true
    }
  end

  # View course details and the topic assigned
  get '/user/courses/:id/enroll' do
    @course = find_course(params[:id])
    @user_enrolled = UserEnrollment.where(
      is_active: true,
      user_id: session[:user_id],
      course_id: @course.id
    ).first
    erb :'/courses/register_course', layout: :layout_admin, locals: {
      page_title: 'Courses', data_table: false
    }
  end

  # post enrollment for user
  post '/courses/:id/postenroll' do
    @course = find_course(params[:id])
    date = params[:start_date]
    date_end = Date.parse(date).to_date + @course.no_days
    @user_enroll = UserEnrollment.create(
      confirmation: 1,
      notes: params[:notes],
      user_id: session[:user_id],
      course_id: params[:id],
      start_date: params[:start_date],
      end_date: date_end,
      is_active: true
    )
    if @user_enroll.save
      construct_new_course_mail_send
      construct_instructor_course_mail_send
      redirect to '/courses'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      erb :'/users/error', locals: {
        user: 'Error:' + @course.errors.full_messages
      }
    end
  end

  # View course details and the topic assigned
  get '/user/courses/view/:id' do
    @course = find_course(params[:id])
    @course_details = CourseDetail.where(
      course_id: params[:id]
    ).order(:day_number)
    @user_enrolled = UserEnrollment.where(
      course_id: params[:id],
      user_id: session[:user_id],
      is_active: true
    ).first
    erb :'/courses/view_course'
  end

  # View all courses  subscribed by a student
  get '/user/mycourses' do
    @subscribed = UserEnrollment.where(
      user_id: current_user.id
    ).all.map do |user_enroll|
      user_enroll.course_id if userenroll.user_id == current_user.id
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
    @courses = Course.where(is_active: true, instructor_id: current_user.id)
    @courses = Course.all.map do |course|
      course.id if course.instructor_id == current_user.id
    end
    @instructor_courses = @courses.compact.map do |c|
      Course.find_by_id(c)
    end
    @subscribed = UserEnrollment.where(
      user_id: current_user.id
    ).all.map do |user_enroll|
      user_enroll.course_id if userenroll.user_id == current_user.id
    end
    @student_courses = @subscribed.compact.map do |c|
      Course.find_by_id(c)
    end
    erb :'/courses/mycourses', locals: {
      page_title: 'My Courses', data_table: false
    }
  end
end
