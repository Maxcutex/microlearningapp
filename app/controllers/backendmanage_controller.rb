# admin manage controller
class BackEndManageController < ApplicationController
  get '/managecourses' do
    if logged_in?
      if is_instructor?
        begin
          @courses = Course.all.order(:id)
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
    begin
      if params[:course_image]
        file = params[:course_image]
        file_name = file[:filename]
        temp_file = file[:tempfile]
        File.open("./public/images/#{file_name}", 'wb') do |f|
          f.write(temp_file.read)
        end
      end
      vari = {
        name: params[:course_name],
        description: params[:course_description],
        is_active: params[:is_active],
        icon: '',
        instructor_id: session[:user_id],
        no_days: params[:course_days],
        category_id: params[:course_category],
        level: params[:course_level],
        course_image: file_name
      }
      if params[:action_type] == 'Add'
        @course = Course.create(vari)
      else
        @course = find_course(params[:id]) if params[:id]
        @course.update(vari)
      end
      if @course.save
        redirect to '/managecourses'
      else
        flash[:error] = 'Kindly fill in all required fields correctly!'
        erb :'/users/error', locals: {
          user: 'Error:' + @course.errors.full_messages
        }
      end
    rescue ActiveRecord::RecordNotFound => e
      erb :'/users/error', locals: { user: 'Error:' + e.message }
    rescue StandardError => e
      erb :'/users/error', locals: { user: e.message }
    end
  end

  get '/accessdenied' do
    erb :'/admin/accessdenied', layout: :layout_admin
  end
end
