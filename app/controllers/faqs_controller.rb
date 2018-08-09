# Faq controller
class FaqsController < ApplicationController
  get '/admin/managefaqs' do
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
  end

  get '/admin/managefaqs/view/:id' do
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

  get '/admin/managefaqs/edit/:id' do
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
      faqvals = { faq_title: params[:faq_title], faq_description: params[:faq_description] }
      @faqs = FAQ.create(faqvals)

      flash[:error] = 'Something went wrong!!!.' until @faqs.save
      redirect to '/managefaqss'
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

      until @faqs.save
        flash[:error] = 'Something went wrong!!!.'
      end
    rescue StandardError => f
      erb :'/users/error', locals: {
        user: f.message, page_title: 'Error',
        data_table: false
      }
    end
  end
end
