require 'spec_helper'

feature 'Sign in user ', :type => :feature do
  given!(:user) { FactoryBot.create(:user_student) }
  scenario 'valid user can sign in ' do
    visit '/login'

    fill_in(:username, with: user.username)
    fill_in(:password, with: user.password)
    click_button 'Submit'
    
    expect(page).to have_text("Dashboard")
  end
end