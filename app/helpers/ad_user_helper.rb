module AdUserHelpers
  def save_process_admin
    if @user.save
      add_role(params[:user][:role_type], @user.id)
      flash[:success] = 'Process successfully created!'
      redirect to '/users'
    else
      flash[:error] = 'Kindly fill in all required fields correctly!'
      flash[:error] += @user.errors.full_messages
      redirect to '/users/new'
    end
  end

  def edit_process_admin
    if @user.save
      edit_role(params[:user][:role_type], @user.id)
      flash[:success] = 'Process successfully updated!'
      redirect to '/users'
    else
      erb :'/users/error', locals: {
        user: @user.errors.full_messages,
        page_title: 'Error Display',
        data_table: false
      }
    end
  end
end
