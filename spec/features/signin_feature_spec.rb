require 'spec_helper'

feature 'Sign in user ' do
  scenario 'valid user can sign in ' do
    visit '/login'

    fill_in(:username, with: 'nili678')
    fill_in(:password, with: 'iesha')
    click_button 'Submit'

    expect(last_response.location).to include('/dashboard')
  end
end