require 'spec_helper'

feature 'User signs in' do
  # let(:user) { create(:fake_user) }
  # let(:student_role) { create(:role_student) }
  let(:student) { create(:student) }

  scenario 'valid details' do
    # binding.pry
    sign_in_with student.user.username, student.user.password

    expect(page).to have_text("Dashboard")
  end

  scenario 'with invalid username' do
    sign_in_with 'invalid_user', 'password'

    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    # binding.pry
    sign_in_with student.user.username, ''

    expect(page).to have_content('Sign in')
    expect(current_path).not_to eq('/user/dashboard')
  end
  
  scenario 'and should not view the login page' do
    sign_in_with student.user.username, student.user.password
    expect(current_path).to eq('/user/dashboard')
    # expect(last_response.location).to include('/dashboard')
    expect(page).to have_content ''
  end
end
