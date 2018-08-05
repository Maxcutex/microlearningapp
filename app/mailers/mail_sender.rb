require 'sendgrid-ruby'
# module for handling registration mails
module MailSender
  include SendGrid

  def sendmail(recipient, topic, message)
    from = Email.new(email: 'ennyboy@gmail.com')
    subject = topic
    to = Email.new(email: recipient)
    content = Content.new(type: 'text/plain', value: message)
    mail = Mail.new(from, subject, to, content)
    # puts JSON.pretty_generate(mail.to_json)
    puts mail.to_json

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
    sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def sendmail_html(recipient, topic, message)
    mail = Mail.new
    mail.from = Email.new(email: 'admin@arentus.com')
    mail.subject = topic
    personalization = Personalization.new
    personalization.add_to(Email.new(email: recipient, name: recipient))
    personalization.subject = topic
    personalization.add_header(Header.new(key: 'X-Test', value: 'True'))
    personalization.add_header(Header.new(key: 'X-Mock', value: 'False'))
    personalization.add_substitution(Substitution.new(key: '%name%', value: 'Example User'))
    personalization.add_substitution(Substitution.new(key: '%city%', value: 'Denver'))
    personalization.add_custom_arg(CustomArg.new(key: 'user_id', value: '343'))
    personalization.add_custom_arg(CustomArg.new(key: 'type', value: 'marketing'))
    mail.add_personalization(personalization)

    mail.add_content(Content.new(type: 'text/plain', value: 'The content of this page can be viewed from your profile'))
    mail.add_content(Content.new(type: 'text/html', value: message))

    # puts JSON.pretty_generate(mail.to_json)
    puts mail.to_json

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
    sg.client.mail._('send').post(request_body: mail.to_json)
    
  end

  def construct_new_mail_send(recipient, first_name, last_name)
    msg = "Dear #{first_name} #{last_name},"\
    'you have successfully'\
    'registered on ASENTUS Micro learning app. Your instructor will approve this'\
    'and you can start learning'
    # file_name = generate_custom_message(first_name, last_name)
    sendmail(recipient, 'Registration on Asentus', msg)
  end

  def construct_new_course_mail_send
    message_to_student = "Dear #{current_user.first_name}"\
    " #{current_user.last_name},\n"\
    'you have successfully'\
    "registered for the course:  [#{@course.name}]. \n\n  Your learning will start on "\
    "#{@user_enroll.start_date}. \n\n Happy Learning !!! \n\n Regards,"
    sendmail(current_user.email, 'Subscription for course', message_to_student)
  end

  def construct_instructor_course_mail_send
    message_to_instructor = "Dear #{@course.instructor.first_name}"\
    "#{@course.instructor.last_name},\n\n A student has successfully"\
    "registered for the #{@course.name}."\
    "Starting date for his/her lecture is on #{@user_enroll.start_date}."\
    '\n\n Regards,'\

    sendmail(@course.instructor.email, 'Subscription by Student', message_to_instructor)
  end

  def construct_unsuscribe_course_mail_send
    message_to_student = "Dear #{current_user.first_name}"\
    " #{current_user.last_name},\n"\
    'you have successfully'\
    "unsubscribed for the course:  [#{@course.name}]. \n\n"\
    'You will no longer recieve email  Learning. Thank you for learning !!!'\
    ' \n\n Regards,'
    sendmail(current_user.email, 'Subscription for course', message_to_student)
  end

  def construct_unsuscribe_instructor_course_mail_send
    message_to_instructor = "Dear #{@course.instructor.first_name}"\
    "#{@course.instructor.last_name},\n\n A student has successfully"\
    "unsubscribed for the #{@course.name}. \n\n Thank you"\
    '\n\n Regards,'
    sendmail(@course.instructor.email, 'Subscription by Student', message_to_instructor)
  end
end
