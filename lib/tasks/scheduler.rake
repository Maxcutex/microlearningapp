desc 'This task is called by the Heroku scheduler add-on'
task send_notifications_learn: :environment do
  puts 'Pulling Notifications and sending...'
  CronTask.task_to_run_at_four_thirty_in_the_morning
  puts 'done.'
end

task send_reminders: :environment do
  User.send_reminders
end
