# admin manage controller
class BackEndManageController < ApplicationController
  get '/managecourses' do
    if logged_in?
      if is_instructor?
        begin
          @courses = Course.all
          erb :'/courses/managecourse'
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

  get '/managecourses/:id' do
    if logged_in?
      if is_instructor?
        begin
          @course = find_course(params[:id]) if params[:id]
          @categories = CourseCategory.all
          loc = { course_id: @course ? @course.id : nil }
          erb :'/courses/managecourse_edit', layout: :layout_admin, locals: loc
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

  post '/postcourse' do
    file_name = ''
    variables = {
      name: params[:course_name],
      description: params[:course_description],
      is_active: params[:is_active],
      icon: '',
      level: params[:level],
      instructor_id: session[:user_id],
      no_days: params[:course_days],
      category_id: params[:course_category]
    }
    if params[:course_image]
      file = params[:course_image]
      file_name = file[:filename]
      temp_file = file[:tempfile]

      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end
    end
    begin
      if params[:action_type] == 'Add'
        @course = Course.create(variables)
        @course.course_image = file_name
        if @course.save
          session[:category_id] = @category.id
        else
          flash[:error] = 'Kindly fill in all required fields correctly!'
        end
      else
        course_inv = Course.find(params[:id]) if params[:id]
        variables[:course_image] = file_name
        course_inv.update(variables)
      end
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: { user: 'Error:' + e.message }
    rescue StandardError => e
      erb :'/users/error', locals: { user: e.message }
    end
    redirect to '/managecourses' 
  end

  get '/accessdenied' do
    erb :'/admin/accessdenied', layout: :layout_admin
  end
end
