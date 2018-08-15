require 'spec_helper'
feature 'Admin can', type: :feature do
  let(:administrator) { create(:administrator) }
  let(:student){ create(:student) }

  scenario 'view user management' do
    sign_in_with administrator.user.username, administrator.user.password

    visit '/admin/users'
    expect(page.body).to have_content('Administration of Users')
  end

  scenario 'add user with role' do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/users/new'
    fill_in 'user[first_name]', with: 'FirstName'
    fill_in 'user[last_name]', with: 'LastName'
    fill_in 'user[biography]', with: 'First_Name'
    fill_in 'user[email]', with: 'First_Name'
    fill_in 'user[username]', with: 'First_Name'
    within '#role_type' do
      find("option[value='2']").click
    end
    check 'user[is_active]'
    click_on 'Add'
    expect(current_path).to eq('/admin/users')
    expect(page.body).to have_content('FirstName')
  end

  scenario 'view exising user' do
    sign_in_with administrator.user.username, administrator.user.password
    visit "/admin/users/edit/#{student.id}"
    expect(page.body).to have_content(student.user.first_name)
  end

  scenario 'edit user details' do
    sign_in_with administrator.user.username, administrator.user.password
    visit "/admin/users/edit/#{student.id}"
    fill_in 'user[first_name]', with: 'EditedFirstName'
    fill_in 'user[last_name]', with: 'LastName'
    fill_in 'user[biography]', with: 'First_Name'
    within '#role_type' do
      find("option[value='2']").click
    end
    check 'user[is_active]'
    click_on 'Edit'

    expect(current_path).to eq('/admin/users')
    expect(page.body).to have_content('EditedFirstName')
  end
end
