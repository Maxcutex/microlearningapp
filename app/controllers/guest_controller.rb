class GuestController < ApplicationController
  get '/about' do
    erb :'/guest/about_us', layout: :layout_web_inner, locals: { contact: false}
  end

  get '/faqs' do
    erb :'/guest/faq', layout: :layout_web_inner, locals: { contact: false}
  end

  get '/courses' do
    erb :'/guest/courses', layout: :layout_web_inner, locals: { contact: false}
  end

  get '/contact' do
    erb :'/guest/contact', layout: :layout_web_inner, locals: { contact: true}
  end
end
