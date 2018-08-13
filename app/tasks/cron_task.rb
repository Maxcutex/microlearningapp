# class to handle cron jobs
class CronTask < ApplicationController
  def task_to_run_at_four_thirty_in_the_morning
    users = User.all
    users.each do |user|
      get_enrolled_courses(user_id)
      @user_enroll_list.each do
        get_last_sent_lesson(user.id, @user_enroll_list.course_id)
        get_lesson_to_send(
          @user_enroll_list.course_id, @user_learnt_last.next_day_number
        )
        message = generatemessage
        send_mail_html(
          user.email, 'Lessons for ' + @topic_day.day_topic, message
        )
      end
    end
  end

  def get_enrolled_courses(user_id)
    @user_enroll_list = UserEnrollment.where(is_active: true, user_id: user_id)
  end

  def get_last_sent_lesson(user_id, course_id)
    @user_learnt_last = UserLearntTrack.where(
      user_id: user_id, course_id: course_id
    ).order(:id).last
  end

  def get_lesson_to_send(course_id, day_number)
    @topic_day = CourseDetail.where(
      course_id: course_id, day_number: day_number
    ).first
  end

  def generatemessage
    url = ENV['APP_URL'] + "'/coursedetail/#{@topic_day.id}'"
    '<p> Below are the details for the topic being learn today'\
      "<p><a href='#{url}' target='_blank'>"\
      "Topic: #{@topic_day.day_topic}</a></p>"\
      '<br><br><h4>Details<h4>'\
      "#{@topic_day.day_details}"
  end
end
