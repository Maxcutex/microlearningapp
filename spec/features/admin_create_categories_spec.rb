require 'spec_helper'
feature 'Admin can' do
  let(:user) { create(:fake_user) }
  let(:admin_role) { create(:role_admin) }
  let(:administrator) { create(:administrator, role: admin_role, user: user) }

  scenario 'view category management' do
    sign_in_with administrator.user.username, administrator.user.password

    visit '/admin/managecategories'
    expect(page).to have_content('Administer Categories')
  end

  scenario 'add category with any category name', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/managecategories/new'
    # binding.pry
    fill_in :category_name, with: 'My Category'
    check 'is_active'
    click_on 'Add'
    # find_button('Add').click
    expect(current_path).to eq('/admin/managecategories')
    expect(page.body).to have_content('My Category')
    # expect(page.body).to have_content('My Category')
  end
end
