# course controller
class CourseDetailController < ApplicationController
  @page_title = ''
  #  Course Details view
  get '/user/coursedetail/:detail_id' do
    begin
      @course_detail = CourseDetail.get_by_detail_id(params[:detail_id])
      binding.pry
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
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: { user: 'Error:' + e.message, page_title: 'Course Detail', data_table: false }
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message, page_title: 'Course Detail', data_table: false }
    end
  end

  #  Course Details Add
  get '/instructor/coursedetail/:course_id/add' do
    @course = find_course(params[:course_id])
    @course_detail = CourseDetail.get_last(params[:course_id])
    last_number = if @course_detail.nil?
                    0
                  else
                    @course_detail.day_number
                  end
    locals = {
      course_id: params[:course_id], action_type: 'Add',
      last_number: last_number, page_title: 'Add Course Detail', data_table: false
    }
    erb :'/courses/course_detail', locals: locals
  end

  post '/editcoursedetail' do
    begin
      check_upload_file_image
      @existing_course_detail = CourseDetail.get_existing(
        params[:day_num], params[:course_id]
      )
      unless @existing_course_detail.nil?
        flash[:error] = 'Topic for the day already exists!'
        flash[:error_title] = 'Error Updating'
        redirect to "/coursedetail/#{params[:course_id]}/edit/#{params[:detail_id]}"
      end
      @course_detail = CourseDetail.get_by_id(params[:detail_id])
      @course_detail.update(
        day_number: params[:day_num],
        day_topic: params[:day_topic],
        day_details: params[:day_details],
        course_id: params[:course_id],
        topic_image: @file_name
      )
      if @course_detail.save
        redirect to "/courses/view/#{params[:course_id]}"
      else
        flash[:error] = 'Kindly fill in all required fields correctly!'
        redirect to "/coursedetail/#{params[:course_id]}/edit/#{@course_detail.id}"
      end
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message, page_title: 'Course Detail', data_table: false }
    end
  end
  #  Course Details Post Add
  post '/postcoursedetail' do
    begin
      check_upload_file_image
      @existing_course_detail = CourseDetail.where(
        day_number: params[:day_num], course_id: params[:course_id]
      ).first

      unless @existing_course_detail.nil?
        flash[:error] = 'Topic for the day already exists!'
        flash[:error_title] = 'Error Adding'
        redirect to "/coursedetail/#{params[:course_id]}/add"
      end
      variables = {
        day_number: params[:day_num],
        day_topic: params[:day_topic],
        day_details: params[:day_details],
        course_id: params[:course_id],
        topic_image: @file_name
      }
      @course_detail = CourseDetail.create(variables)
      if @course_detail.save
        redirect to "/courses/view/#{params[:course_id]}"
      else
        flash[:error] = 'Kindly fill in all required fields correctly!'
        redirect to "/coursedetail/#{params[:course_id]}/add"
      end
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message , page_title: 'Course Detail', data_table: false}
    end
  end

  #  Course Details Edit
  get '/instructor/coursedetail/:course_id/edit/:detail_id' do
    @course = find_course(params[:course_id])
    @course_detail = CourseDetail.where(id: params[:detail_id]).first
    loc = { course_id: params[:course_id], action_type: 'Edit', page_title: 'Course Detail', data_table: false }
    erb :'/courses/course_detail', locals: loc
  end
end
