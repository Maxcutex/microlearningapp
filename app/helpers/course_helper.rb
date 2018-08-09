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
  end

  def save_and_redirect
    if params[:action_type] == 'Add'
      @course = Course.create(parameters)
    else
      @course = find_course(params[:id]) if params[:id]
      @course.update(parameters)
    end
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
end
