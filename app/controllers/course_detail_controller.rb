# course controller
class CourseDetailController < ApplicationController
  #  Course Details view
  get '/coursedetail/:detail_id' do
    begin
      @coursedetail = CourseDetails.where(id: params[:detail_id]).first
      @userenrolled = UserEnrollment.where(
        user_id: session[:user_id],
        course_id: @coursedetail.course_id
      ).first
      @course = find_course(@coursedetail.course_id)
      if current_user.id == @course.instructor_id || !@userenrolled.nil?
        erb :'courses/course_detail_view'
      else
        erb :'courses/access_denied'
      end
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: { user: 'Error:' + e.message }
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message }
    end
  end

  #  Course Details Add
  get '/coursedetail/:course_id/add' do
    @course = find_course(params[:course_id])
    @coursedetail = CourseDetails.where(
      course_id: params[:course_id]
    ).order(:day_number).last
    if @coursedetail.nil?
      last_number = 0
    else
      last_number = @coursedetail.day_number
    end
    loc = {
      course_id: params[:course_id], action_type: 'Add',
      last_number: last_number
    }
    erb :'/courses/course_detail', locals: loc
  end

  #  Course Details Post Add
  post '/postcoursedetail' do
    ce = params[:action_type]
    file_name = ''
    begin
      if params[:topic_image]
        file = params[:topic_image]
        file_name = file[:filename]
        temp_file = file[:tempfile]
        File.open("./public/images/#{file_name}", 'wb') do |f|
          f.write(temp_file.read)
        end
      end
      @checkdet = CourseDetails.where(
        day_number: params[:day_num], course_id: params[:course_id]
      ).first

      if ce == 'Add'
        unless @checkdet.nil?
          flash[:error] = 'Topic for the day already exists!'
          flash[:error_title] = 'Error Adding'
          redirect to "/coursedetail/#{params[:course_id]}/add"
        end
        variables = {
          day_number: params[:day_num],
          day_topic: params[:day_topic],
          day_details: params[:day_details],
          course_id: params[:course_id],
          topic_image: file_name
        }
        @coursedet = CourseDetails.create(variables)

      else
        unless @checkdet.nil?
          flash[:error] = 'Topic for the day already exists!'
          flash[:error_title] = 'Error Updating'
          redirect to "/coursedetail/#{params[:course_id]}/edit/#{params[:detail_id]}"
        end
        @coursedet = CourseDetails.where(id: params[:detail_id]).first
        @coursedet.update(
          day_number: params[:day_num],
          day_topic: params[:day_topic],
          day_details: params[:day_details],
          course_id: params[:course_id],
          topic_image: file_name
        )
      end
      if @coursedet.save
        redirect to "/courses/view/#{params[:course_id]}"
      else
        flash[:error] = 'Kindly fill in all required fields correctly!'
        redirect to "/coursedetail/#{params[:course_id]}/add"
      end
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: { user: 'Error:' + e.message }
    rescue StandardError => f
      erb :'/users/error', locals: { user: f.message }
    end
  end

  #  Course Details Edit
  get '/coursedetail/:course_id/edit/:detail_id' do
    @course = find_course(params[:course_id])
    @coursedetailedit = CourseDetails.where(id: params[:detail_id]).first
    loc = { course_id: params[:course_id], action_type: 'Edit' }
    erb :'/courses/course_detail', locals: loc
  end
end
