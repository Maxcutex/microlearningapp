require 'spec_helper'

feature 'Register signs in' do
  before do
   @user =  generate_user_values
  end
  scenario 'valid details' do
    sign_up(@user)
    expect(page).to have_text("Dashboard")
  end

  scenario 'with existing username' do
    user1 = generate_user_values
    user1[:username] = @user[:username]
    sign_up(user1)
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Username has already been taken')
  end

  scenario 'with existing email' do
    user1 = generate_user_values
    user1[:email] = @user[:email]
    sign_up(user1)
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Email has already been taken')
  end
  scenario 'with blank password' do
    user1 = generate_user_values
    user1[:password] = nil
    user1[:password_confirmation] = nil
    sign_up(user1)
    expect(page).to have_content('Sign in')
  end

end
