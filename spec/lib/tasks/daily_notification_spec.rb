require 'spec_helper'
require 'rake'
describe 'notify:users', type: :task do
  # include_context "rake"
  let(:administrator) { create(:administrator) }
  let(:instructor) { create(:instructor) }
  let(:course_list) { create_list(:course, 10) }
  let(:student_list) { create_list(:student, 10) }
  let(:user_learnt_track) { create_list(:user_learnt_track) }

  before do
    load File.expand_path('../../../../lib/tasks/scheduler.rake', __FILE__)
    # Rake.application.rake_require "task/schedular"
    Rake::Task.define_task(:environment)
  end

  let :run_rake_task do
    Rake::Task['task_runner:send_notifications_learn'].reenable
    Rake.application.invoke_task 'task_runner:send_notifications_learn'
  end

  it "send notifications to enrolled users" do
    run_rake_task
  end
end
