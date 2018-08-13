require 'spec_helper'

describe CategoryController do
  let(:administrator) { create(:administrator) }
    let(:user_session) {
      {
        'rack.session' => {
          user_id: administrator.user.id, role_name: administrator.role.role_name
        }
      }
    }
  context 'A logged in admin viewing GET /admin/managecategories' do
    let(:response) { get '/admin/managecategories', {}, user_session }
    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'displays a list registered courses' do
      expect(response.body).to include(
        'Categories'
      )
    end
  end

  context 'A logged in admin viewing GET /admin/managecategories/new' do
    let(:response) { get '/admin/managecategories/new', {}, user_session }
    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end
  end

  context 'A logged in admin viewing GET /admin/managecategories/edit/:id' do
    let(:category) { create(:category) }
    let(:response) { get "/admin/managecategories/edit/#{category.id}", {}, user_session }
    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'returns error message if category does not exist' do
      get "/admin/managecategories/edit/24", {}, user_session
      expect(last_response.location).to include('/admin/managecategories')
    end
  end

  context "POST to /members" do
    context "given a valid category" do
      it "adds the category to the database"
      it "returns status 302 Found"
      it "redirects to /admin/managecategories"
    end

    context "given an empty name" do
      it "does not add the category to the database"
      it "returns status 200 OK"
      it "displays a form that POSTs to /members"
      it "displays a form error in pop up"
    end
  end
end
