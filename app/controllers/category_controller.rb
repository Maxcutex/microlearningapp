# Category controller for managing categories
class CategoryController < ApplicationController
  get '/managecategories/?:id?' do
    if logged_in?
      if is_admin?
        begin
          @category = CourseCategory.find(params[:id]) if params[:id]
          @categories = CourseCategory.all
          loc = { category_id: @category ? @category.id : nil }
          erb :'/courses/managecategories', locals: loc
        rescue ActiveRecord::RecordNotFound => e
          erb :'/users/error', locals: { user: 'Error:' + e.message }
        rescue StandardError => f
          erb :'/users/error', locals: { user: f.message }
        end
      else
        flash[:error] = 'You are not currently logged in!'
        redirect to :'/accessdenied'
      end

    else
      flash[:error] = 'You are not currently logged in!'
      redirect to :'/login'
    end
  end

  post '/postcategory' do
    variables = {
      category_name: params[:category_name],
      is_active: params[:is_active]
    }
    if params[:action_type] == 'Add'
      @category = CourseCategory.create(variables)
    else
      @category = CourseCategory.find(params[:id]) if params[:id]
      @category.category_name = params[:category_name]
      @category.is_active = params[:is_active]
    end
    save_category
  end

  def save_category
    if @category.save
      session[:category_id] = @category.id
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
    end
    redirect to '/managecategories'
  end
end
