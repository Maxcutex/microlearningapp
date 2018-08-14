# Faq controller
class FaqsController < ApplicationController
  get '/admin/managefaqs' do
    begin
      @faqs = FAQ.all_faqs
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
    @faq = FAQ.get_by_id(params[:id])
    erb :'faqs/view_faq', locals: {
      page_title: 'FAQ View',
      data_table: false
    }
  end

  get '/admin/managefaqs/edit/:id' do
    @faq = FAQ.get_by_id(params[:id])
    erb :'faqs/edit_faq', layout: :layout_admin, locals: {
      page_title: 'FAQ View',
      data_table: false
    }
  end

  post '/postnew' do
    faqvals = { faq_title: params[:faq_title], faq_description: params[:faq_description] }
    @faqs = FAQ.create(faqvals)
    if @faqs.save
    else 
      flash[:error] = 'Something went wrong!!!.'
    end
    redirect to '/admin/managefaqs'
  end

  post '/postedit' do
    faqvals = { faq_title: params[:faq_title], faq_description: params[:faq_description] }
    @faqs = FAQ.get_by_id(params[:id])
    @faqs.update(faqvals)
    if @faqs.save
      redirect to '/admin/managefaqs'
    else
      flash[:error] = 'Something went wrong!!!.'
      redirect to "/admin/managefaqs/edit/#{@faqs.id}"
    end
  end
end
