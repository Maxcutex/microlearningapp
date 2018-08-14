require 'spec_helper'

describe 'User Can', type: :controller do
  context 'With Instructor Role' do
    let(:instructor) { create(:instructor) }
    let(:user_session) {
      {
        'rack.session' => {
        user_id: instructor.user.id, role_name: instructor.role.role_name
        }
      }
    }
    it 'is redirected to dashboard on viewing login page' do
      get '/login', {}, user_session
      expect(last_response.location).to include('/user/dashboard')
    end
    it 'is redirected to login after logging out' do
      get '/logout', {}, user_session
      expect(last_response.location).to include('/login')
    end
    it 'is shown accessdenied when redirected' do
      response = get '/accessdenied', {}, user_session
      expect(response.body).to include('You are not allowed access to view this page')
    end
    it 'have access to manage courses' do
      response = get '/instructor/managecourses', {}, user_session
      expect(response.status).to eq(200)
    end
    it 'not have access to manage users' do
      get '/admin/users', {}, user_session
      expect(last_response.location).to include('/accessdenied')
    end
    it 'not have access to manage categories' do
      get '/admin/users', {}, user_session
      expect(last_response.location).to include('/accessdenied')
    end

    it 'should redirect to courses page if logged in' do
      get '/', {}, user_session
      expect(last_response.location).to include('/user/courses')
    end
  end

  context 'With Admin' do
    let(:administrator) { create(:administrator) }
    let(:user_session) {
      {
        'rack.session' => {
        user_id: administrator.user.id, role_name: administrator.role.role_name
        }
      }
    }
    it 'should not have access to manage courses' do
      get '/instructor/managecourses', {}, user_session
      expect(last_response.location).to include('/accessdenied')
    end
    it 'should have access to manage users' do
      response = get '/admin/users', {}, user_session
      expect(response.status).to eq(200)
    end
  end
end
