require 'pony'
# course controller
class CourseController < ApplicationController
  @page_title = ''
  def sendmail(recipient, topic, message)
    Pony.options = {
      via: :smtp, headers: { 'Content-Type' => 'text/html' },
      body: message, subject: topic, via_options: {
        address: 'smtp.gmail.com', port: '587',
        enable_starttls_auto: true, user_name: ENV['GMAIL_ID'],
        password: ENV['GMAIL_PASS'], authentication: :plain,
        domain: 'localhost.localdomain'
      }
    }
    Pony.mail(to: recipient, from: 'ennyboy@gmail.com')
  end

  # View all courses
  get '/courses' do
    if logged_in?
      @courses = Course.where(is_active: true)
      @userenrolled = UserEnrollment.where(
        is_active: true,
        user_id: session[:user_id]
      )
      erb :'/courses/index', locals: {
        page_title: 'Courses', data_table: false
      }
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  # View course details and the topic assigned
  get '/courses/:id/enroll' do
    if logged_in?
      @course = find_course(params[:id])
      @userenrolled = UserEnrollment.where(
        is_active: true,
        user_id: session[:user_id],
        course_id: @course.id
      ).first
      erb :'/courses/register_course', layout: :layout_admin
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
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
      # send mail to student
      message_to_student = "Dear #{current_user.first_name} #{current_user.last_name},"\
       'you have successfully'\
       "registered for the #{@course.name}. Your instructor will approve this"\
       'and you can start learning'

      sendmail(current_user.email, 'Subscription for course', message_to_student)
      # send mail to instructor
      message_to_instructor = "Dear #{@course.instructor.first_name} #{course.instructor.last_name},"\
      'A student has successfully'\
      "registered for the #{@course.name}. Your instructor kindly approve this"\
      'application so that the student can  start learning'\
      "Click on the link below to approve <br> <a href='f'>Click Here</a>"
      sendmail(@course.instructor.email, 'Subscription by Student', message_to_instructor)

      redirect to '/courses'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      erb :'/users/error', locals: {
        user: 'Error:' + @course.errors.full_messages
      }
    end
  end

  # View course details and the topic assigned
  get '/courses/view/:id' do
    if logged_in?
      @course = find_course(params[:id])
      @coursedetails = CourseDetails.where(
        course_id: params[:id]
      ).order(:day_number)
      @userenrolled = UserEnrollment.where(
        course_id: params[:id],
        user_id: session[:user_id],
        is_active: true
      ).first
      erb :'/courses/view_course'
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
      @subscribed = UserEnrollment.where(
        user_id: current_user.id
      ).all.map do |userenroll|
        userenroll.course_id if userenroll.user_id == current_user.id
      end
      @student_courses = @subscribed.compact.map do |c|
        Course.find_by_id(c)
      end
      erb :'/courses/mycourses', locals: {
        page_title: 'My Courses', data_table: false
      }
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end
end
