module Features
  module SessionHelpers
    def generate_user_values
      password = Faker::Internet.password
      {
        first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
        username: Faker::Internet.username, email: Faker::Internet.email,
        password: password, password_confirmation: password,
        biography: Faker::Lorem.paragraph(2, true, 4)
      }
    end

    def sign_up(user_values)
      visit sign_up_path
      fill_in('user_first_name', with: user_values[:first_name])
      fill_in('user_last_name', with: user_values[:last_name])
      fill_in('user_username', with: user_values[:username])
      fill_in('user_email', with: user_values[:email])
      fill_in('user_password', with: user_values[:password])
      fill_in('user_password_confirmation', with: user_values[:password])
      fill_in('user_biography', with: user_values[:biography])
      click_button 'Register'
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
