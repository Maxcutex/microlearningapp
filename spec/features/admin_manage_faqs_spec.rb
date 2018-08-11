require 'spec_helper'
feature 'Admin can', type: :feature do
  let(:administrator) { create(:administrator) }
  let(:faq) { create(:faq) }

  scenario 'view FAQ management' do
    sign_in_with administrator.user.username, administrator.user.password

    visit '/admin/managefaqs'
    expect(page.body).to have_content('Manage FAQs')
  end

  scenario 'add new faq', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit '/admin/managefaqs'
    fill_in :faq_title, with: 'this is what you should know'
    fill_in :faq_description, with: '<p>The details should be longer than this</p>'

    click_on 'Add'
    expect(current_path).to eq('/admin/managefaqs')
    expect(page.body).to have_content('this is what you should know')
  end

  scenario 'view exising faq' do
    sign_in_with administrator.user.username, administrator.user.password
    visit "/admin/managefaqs/view/#{faq.id}"
    expect(page.body).to have_content(faq.faq_title)
  end

  scenario 'edit faq', :js do
    sign_in_with administrator.user.username, administrator.user.password
    visit "/admin/managefaqs/edit/#{faq.id}"
    fill_in :faq_title, with: 'this is what is edited'
    fill_in :faq_description, with: '<p>The details should be longer than this</p>'

    click_on 'Edit'

    expect(current_path).to eq('/admin/managefaqs')
    expect(page.body).to have_content('this is what is edited')
  end
end
