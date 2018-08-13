require 'spec_helper'

describe GuestController do
  context 'GET to /' do
    let(:response) { get '/' }
    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end
    it 'displays a list of menu links' do
      expect(response.body).to include(
        '<a class="nav-item-child nav-item-hover active" href="/">Home</a>',
        '<a class="nav-item-child nav-item-hover" href="/about">About</a>',
        '<a class="nav-item-child nav-item-hover" href="/faq">FAQ</a>',
        '<a class="nav-item-child nav-item-hover" href="/contact">Contact</a>',
        '<a class="nav-item-child nav-item-hover" href="/login">Sign In</a>'
      )
    end
  end

  context 'GET to /about' do
    let(:response) { get '/about' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end
    it 'displays content of about us' do
      expect(response.body).to include(
        'About Us'
      )
    end
  end
  context 'GET to /faqs' do
    let(:response) { get '/faqs' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end
    it 'displays content of faq' do
      expect(response.body).to include(
        'FAQ'
      )
    end
  end

  context 'GET to /courses' do
    let(:response) { get '/courses' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end
    it 'displays a form that POSTs to /members'
    it 'displays an input tag for the name'
    it 'displays a submit tag'
  end

  context 'POST to /contact' do
      let(:response) { get '/contact' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'displays content of contact' do
      expect(response.body).to include(
        'Contact'
      )
    end
    

  end
end