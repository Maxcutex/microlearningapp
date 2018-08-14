# Category controller for managing categories
class CategoryController < ApplicationController
  get '/admin/managecategories' do
    @categories = CourseCategory.all_categories
    page_title = 'Manage Categories'
    loc = {
      category_id: @category ? @category.id : nil,
      page_title: page_title, data_table: false
    }
    erb :'/courses/managecategories', locals: loc
  end

  get '/admin/managecategories/new' do
    page_title = 'Manage Categories'
    loc = {
      category_id: @category ? @category.id : nil,
      page_title: page_title, data_table: false
    }
    erb :'/courses/new_category', locals: loc
  end

  get '/admin/managecategories/edit/:id' do
    @category = CourseCategory.get_category_by_id(params[:id]) if params[:id]
    page_title = 'Manage Categories'
    loc = {
      category_id: @category ? @category.id : nil,
      page_title: page_title, data_table: false
    }
    if @category.nil?
      flash[:error] = 'No record found.'
      redirect to '/admin/managecategories'
    end
    erb :'/courses/edit_category', locals: loc
  end

  post '/post_edit_category' do
    isactive = true
    if params[:is_active].nil?
      isactive = false
    end
    @category = CourseCategory.get_category_by_id(params[:id]) if params[:id]
    @category.category_name = params[:category_name]
    @category.is_active = isactive
    save_category
  end

  post '/post_new_category' do
    @category = CourseCategory.new(
      category_name: params[:category_name],
      is_active: true
    )
    save_category
  end
  def save_category
    if @category.save
      session[:category_id] = @category.id
      redirect to '/admin/managecategories'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      erb :'/users/error', locals: { user: @category.errors.messages, page_title: 'Error', data_table: false }

    end
  end
end
