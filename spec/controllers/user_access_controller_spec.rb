require 'spec_helper'

describe 'User Can', type: :controller do
  let(:instructor) { create(:instructor) }
  let(:administrator) { create(:administrator) }
  it 'loads the manage courses page if user is an admin' do
    sign_in_with instructor.user.username, instructor.user.password
    visit '/instructor/managecourses'
    expect(page.status_code).to eq(200)
  end

  it 'not load manage courses if not an instructor' do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/instructor/managecourses'
    expect(page.body).to include('You are not allowed access to this page')
  end

  it 'not load manage categories if not an administrator' do
    sign_in_with instructor.user.username, instructor.user.password
    visit '/admin/managecategories'
    expect(page.body).to include('You are not allowed access to this page')
  end

  it 'not load list of users if not an administrator' do
    sign_in_with instructor.user.username, instructor.user.password
    visit '/admin/users'
    expect(page.body).to include('You are not allowed access to this page')
  end
end
