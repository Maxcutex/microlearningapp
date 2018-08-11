require_relative '../helpers/course_helper'
# course controller
class CourseDetailController < ApplicationController
  include CourseHelpers
  @page_title = ''
  #  Course Details view
  get '/user/coursedetail/:detail_id' do
    begin
      @course_detail = CourseDetail.get_by_detail_id(params[:detail_id])
      @user_enrolled = UserEnrollment.get_enrollment(
        user_id: session[:user_id],
        course_id: @coursedetail.course_id
      )
      locals = {
        course_id: params[:course_id], action_type: 'Add',
        last_number: last_number, page_title: 'Add Course Detail', data_table: false
      }
      @course = find_course(@course_detail.course_id)
      if current_user.id == @course.instructor_id || !@user_enrolled.nil?
        erb :'courses/course_detail_view', locals: locals
      else
        erb :'courses/access_denied'
      end
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message, page_title: 'Course Detail', data_table: false }
    end
  end

  #  Course Details Add
  get '/instructor/coursedetail/:course_id/add' do
    set_page_parameters
    locals = {
      course_id: params[:course_id], action_type: 'Add',
      last_number: @last_number, page_title: 'Add Course Detail',
      post_url: '/editcoursedetail', data_table: false
    }
    erb :'/courses/course_detail', locals: locals
  end

  post '/editcoursedetail' do
    begin
      check_upload_file_image
      fetch_set_course_detail
      save_course_details("/instructor/coursedetail/#{params[:course_id]}/edit/#{@course_detail.id}")
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message, page_title: 'Course Detail', data_table: false }
    end
  end
  #  Course Details Post Add
  post '/postcoursedetail' do
    begin
      check_upload_file_image
      check_if_details_exists
      create_course_detail
      save_course_details("/instructor/coursedetail/#{params[:course_id]}/add")
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'ProcessingCourse Detail', data_table: false
      }
    end
  end

  #  Course Details Edit
  get '/instructor/coursedetail/:course_id/edit/:detail_id' do
    @course = find_course(params[:course_id])
    @course_detail = CourseDetail.get_by_id(params[:detail_id])
    locals = {
      course_id: params[:course_id],
      action_type: 'Edit',
      page_title: 'Edit Course Detail', post_url: '/editcoursedetail', data_table: false
    }
    erb :'/courses/course_detail', locals: locals
  end
end
