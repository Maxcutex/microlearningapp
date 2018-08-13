require 'spec_helper'
feature 'User can', type: :feature do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:user_enrollment) { create(:user_enrollment, user: student.user) }

  scenario 'enroll for a course' do
    sign_in_with student.user.username, student.user.password
    session = {}
    session[:user_id] = student.user.id
    session[:role_name] = student.role.role_name
    visit "/user/courses/#{course.id}/enroll"
    fill_in :datepicker, with: '18/09/2018'
    click_on 'Enroll'
    # binding.pry
    expect(current_path).to eq('/user/courses')
    expect(page).to have_content('Courses')
  end

  scenario 'unsubscribe successfully for a registered course' do
    sign_in_with student.user.username, student.user.password
    visit "/user/courses/#{user_enrollment.course.id}/unsubscribe"
    expect(current_path).to eq('/user/courses')
    expect(page).to have_content('Courses')
  end
end
