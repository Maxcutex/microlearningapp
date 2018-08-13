require 'spec_helper'
feature 'User can', type: :feature do
  let(:student) { create(:student) }

  scenario 'edit his/her profile' do
    sign_in_with student.user.username, student.user.password
    session = {}
    session[:user_id] = student.user.id
    session[:role_name] = student.role.role_name

    visit '/user/profile'
    fill_in 'user[first_name]', with: 'Editedfirstname'
    fill_in 'user[last_name]', with: 'editedlastname'
    attach_file('Image Upload', 'spec/uploads/him.jpg')
    click_button 'Submit'
    expect(current_path).to eq('/user/profile')
  end

 
end
