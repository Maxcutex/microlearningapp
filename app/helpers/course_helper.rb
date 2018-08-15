# module for helping process course and course details
module CourseHelpers
  def initialize_course_post
    @course = find_course(params[:id])
    date = params[:start_date]
    date_end = Date.parse(date).to_date + @course.no_days
    @user_enroll = UserEnrollment.create(
      confirmation: 1, notes: params[:notes], user_id: session[:user_id],
      course_id: params[:id], start_date: params[:start_date],
      end_date: date_end, is_active: true
    )
  end

  def process_file_parameters
    {
      name: params[:course_name], description: params[:course_description],
      is_active: params[:is_active], icon: '', instructor_id: session[:user_id],
      no_days: params[:course_days], category_id: params[:course_category],
      level: params[:course_level]
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

  def get_existing_enrollment(course_id, user_id)
    @user_enrollment = UserEnrollment.get_enrollment(user_id, course_id)
    @user_enrollment.is_active = false
  end

  def process_unsubscribe(course_id, user_id)
    get_existing_enrollment(course_id, user_id)
    @course = find_course(course_id)
    if @user_enrollment.save
      construct_unsuscribe_course_mail_send
      construct_unsuscribe_instructor_course_mail_send
      flash[:success] = 'Subscription Successfull'
    else
      flash[:error] = 'Subscription Unsuccessfull!'
    end
    redirect to '/user/courses'
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
    @existing_course_detail = CourseDetail.get_existing(params[:day_num], params[:course_id])
    unless @existing_course_detail.nil?
      flash[:error] = 'Topic for the day already exists!'
      flash[:error_title] = 'Error Adding'
      redirect to "/instructor/coursedetail/#{params[:course_id]}/add"
    end
  end

  def create_course_detail
    variables = {
      day_number: params[:day_num], day_topic: params[:day_topic],
      day_details: params[:day_details],
      course_id: params[:course_id]
    }
    @course_detail = CourseDetail.create(variables)
  end

  def fetch_set_course_detail
    @course_detail = CourseDetail.get_by_id(params[:detail_id])
    @course_detail.update(
      day_number: params[:day_num], day_topic: params[:day_topic],
      day_details: params[:day_details],
      course_id: params[:course_id]
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
