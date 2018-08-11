# module for helping process course and course details
module CourseHelpers
  def initialize_course_post
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
  end

  def process_file_parameters
    file_name = ''
    if params[:course_image]
      file = params[:course_image]
      file_name = file[:filename]
      course_temp_file = file[:tempfile]
      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(course_temp_file.read)
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
  end

  def save_and_redirect
    if @course.save
      redirect to '/instructor/managecourses'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      erb :'/users/error', locals: {
        user: 'Error:' + @course.errors.full_messages, page_title: 'Error',
        data_table: false
      }
    end
  end

  def check_upload_file_image
    @file_name = ''
    unless params[:topic_image].nil?
      file = params[:topic_image]
      file_name = file[:filename]
      temp_file = file[:tempfile]
      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end
    end
  end

  def save_course_details(url)
    if @course_detail.save
      redirect to "/user/courses/view/#{params[:course_id]}"
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      redirect to url
    end
  end

  def check_if_details_exists
    @existing_course_detail = CourseDetail.where(
      day_number: params[:day_num], course_id: params[:course_id]
    ).first
    unless @existing_course_detail.nil?
      flash[:error] = 'Topic for the day already exists!'
      flash[:error_title] = 'Error Adding'
      redirect to "/instructor/coursedetail/#{params[:course_id]}/add"
    end
  end

  def create_course_detail
    variables = {
      day_number: params[:day_num],
      day_topic: params[:day_topic],
      day_details: params[:day_details],
      course_id: params[:course_id],
      topic_image: @file_name
    }
    @course_detail = CourseDetail.create(variables)
  end

  def fetch_set_course_detail
    @course_detail = CourseDetail.get_by_id(params[:detail_id])
    @course_detail.update(
      day_number: params[:day_num],
      day_topic: params[:day_topic],
      day_details: params[:day_details],
      course_id: params[:course_id],
      topic_image: @file_name
    )
  end

  def set_page_parameters
    @course = find_course(params[:course_id])
    @course_detail = CourseDetail.get_last(params[:course_id])
    @last_number = if @course_detail.nil?
                    0
                  else
                    @course_detail.day_number
                  end
  end
end
