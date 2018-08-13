require 'spec_helper'
feature 'Admin can', type: :feature do
  let(:administrator) { create(:administrator) }

  scenario 'view category management' do
    sign_in_with administrator.user.username, administrator.user.password

    visit '/admin/managecategories'
    expect(page).to have_content('Administer Categories')
  end

  scenario 'add category with any category name', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/managecategories/new'
    fill_in :category_name, with: 'My Category'
    check 'is_active'
    click_on 'Add'
    expect(current_path).to eq('/admin/managecategories')
    expect(page.body).to have_content('My Category')
  end

  scenario 'view exising category', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/managecategories/new'
    fill_in :category_name, with: 'My Category2'
    check 'is_active'
    click_on 'Add'
    expect(current_path).to eq('/admin/managecategories')
    expect(page.body).to have_content('My Category2')
    visit '/admin/managecategories/edit/1'
    expect(page).to have_content('Edit Category - My Category2')
  end

  scenario 'edit category with any category name', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/managecategories/new'
    # binding.pry
    fill_in :category_name, with: 'My Category'
    check 'is_active'
    click_on 'Add'
    # find_button('Add').click
    expect(current_path).to eq('/admin/managecategories')
    expect(page.body).to have_content('My Category')
    visit '/admin/managecategories/edit/1'
    expect(page).to have_content('Edit Category - My Category')

    fill_in :category_name, with: 'My New Category'
    check 'is_active'
    click_on 'Edit'

    expect(current_path).to eq('/admin/managecategories')
    expect(page.body).to have_content('My New Category')
  end
end
