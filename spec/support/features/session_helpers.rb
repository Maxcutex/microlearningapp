module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit sign_up_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end

    def sign_in_with(username, password)
      visit sign_in_path
      fill_in(:username, with: username)
      fill_in(:password, with: password)
      click_button 'Submit'
    end

    def sign_in_path
      '/login'
    end

    def sign_up_path
      '/signup'
    end
  end
end
