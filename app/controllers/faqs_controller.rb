# Faq controller
class FaqsController < ApplicationController
  get '/managefaqs' do
    if logged_in?
      if is_admin?
        begin
          @faqs = FAQ.all.order(:id)
          page_title = 'Manage Faqs'
          loc = {
            page_title: page_title, data_table: true
          }
          erb :'/faqs/listfaqs', layout: :layout_admin, locals: loc
        rescue StandardError => f
          erb :'/users/error', locals: {
            user: f.message, page_title: 'Error',
            data_table: false
          }
        end
      else
        flash[:error] = 'You do not have access!'
        redirect to :'/accessdenied'
      end
    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  get '/managefaqs/view/:id' do
    begin
      @faq = FAQ.where(id: params[:id]).first
      erb :'faqs/view_faq', locals: {
        page_title: 'FAQ View',
        data_table: false
      }
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error',
        data_table: false
      }
    end
  end

  get '/managefaqs/edit/:id' do
    begin
      @faq = FAQ.where(id: params[:id]).first
      erb :'faqs/edit_faq', layout: :layout_admin, locals: {
        page_title: 'FAQ View',
        data_table: false
      }
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error',
        data_table: false
      }
    end
  end 

  post '/postnew' do
    begin
      faqvals = { faq_title: params[:faq_title], faq_description: params[:faq_description]}
      @faqs = FAQ.create(faqvals)
      if @faqs.save
        redirect to '/managefaqs'
      else 
      end 
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error',
        data_table: false
      }
    end
  end

  post '/postedit' do
    begin
      faqvals = { faq_title: params[:faq_title], faq_description: params[:faq_description]}
      @faqs = FAQ.where(id: params[:id]).first
      @faqs.update(faqvals)
      if @faqs.save
        redirect to '/managefaqs'
      else
        flash[:error] = 'Kindly fill the form details!!!'
      end
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error',
        data_table: false
      }
    end
  end
end
