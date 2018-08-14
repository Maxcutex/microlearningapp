require_relative '../../app/mailers/mail_sender'
include MailSender

# Tasks for microlearning app
namespace :task_runner do
  desc 'This task can also be called by the Heroku scheduler add-on, it send notification to all students'
  task :send_notifications_learn do
    puts 'Pulling Notifications and sending...'
    notify_users
    puts 'done.'
  end
  desc 'This task sends reminders about reading the app'
  task :send_reminders do
    User.send_reminders
  end

  def notify_users
    users = User.all_users
    users.each do |user|
      get_enrolled_courses(user.id)
      @user_enroll_list.each do |user_enroll|
        user_learnt_last = get_last_sent_lesson(user.id, user_enroll.course_id)
        @course = Course.get_by_id(user_enroll.course_id)
        current_day = 0
        if user_learnt_last.nil?
          current_day = 1
        else
          current_day = user_learnt_last.next_day_number
        end
        get_lesson_to_send(user_enroll.course_id, current_day)
        next_day = current_day + 1
        if next_day > @course.no_days
          next_day = 0
        end
        update_last_sent_message(user_enroll.id, current_day, next_day)
        message1 = generatemessage
        send_mail_html(
          user.email, 'Lessons for ' + @topic_day.day_topic, message1
        )
      end
    end
  end

  def get_enrolled_courses(user_id)
    @user_enroll_list = UserEnrollment.active_user_enrollment(user_id)
  end

  def update_last_sent_message(enroll_id, day_number, next_day_number)
    @user_learnt_last = UserLearntTrack.new(
      user_enrollment_id: enroll_id,
      day_number: day_number, next_day_number: next_day_number
    )
    @user_learnt_last.save
  end

  def get_last_sent_lesson(user_id, course_id)
    UserLearntTrack.get_last_track_by_user_id(user_id, course_id)
  end

  def self.get_lesson_to_send(course_id, day_number)
    @topic_day = CourseDetail.get_existing(day_number, course_id)
  end

  def generatemessage
    url = ENV['APP_URL'].to_s + "'/coursedetail/#{@topic_day.id}'"
    '<p> Below are the details for the topic being learn today'\
      "<p><a href='#{url}' target='_blank'>"\
      "Topic: #{@topic_day.day_topic}</a></p>"\
      '<br><br><h4>Details<h4>'\
      "#{@topic_day.day_details}"
  end
end
