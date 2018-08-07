require 'spec_helper'

feature 'Signed in User signs out' do
  let(:user) { create(:dynamic_user) }
  let(:student_role) { create(:role_student) }
  let(:student) { create(:student, role: student_role, user: user) }

  scenario 'valid user can logout' do
    sign_in_with student.user.username, student.user.password
    expect(page).to have_text('Dashboard')
    get '/logout'
    expect(last_response.location).to include('/')
  end

end