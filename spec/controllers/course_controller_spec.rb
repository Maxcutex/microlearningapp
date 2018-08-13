require 'spec_helper'

describe CourseController do
  context 'A logged in user viewing GET /user/mycourses/' do
    let(:student) { create(:student) }
    let(:user_session) {
      {
        'rack.session' => {
          user_id: student.user.id, role_name: student.role.role_name
        }
      }
    }
    let(:response) { get '/user/mycourses', {}, user_session }
    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'displays a list registered courses' do
      expect(response.body).to include(
        'Courses'
      )
    end
  end

  context 'A guest user' do
    let(:response) { get '/user/mycourses' }
    it 'is redirected to login page' do
      get '/user/courses'
      expect(last_response.location).to include('/login')
    end
  end
end
