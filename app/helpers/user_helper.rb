# Module for handling actions to avoid DRY
module UserHelpers
  def upload_image
    if params[:user_image].nil?
      @fname = ''
    else
      file = params[:user_image]
      file_name = file[:filename]
      temp_file = file[:tempfile]
      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end
      @fname = file_name
    end
  end

  
  
  def set_session_create_values
    session[:user] = params[:user]
  end

  def process_new
    postuser = params[:user]
    user = {
      first_name: postuser[:first_name], last_name: postuser[:last_name],
      username: postuser[:username], email: postuser[:email],
      user_image: @fname, password: postuser[:password],
      password_confirmation: postuser[:password],
      biography: postuser[:biography], is_active: postuser[:is_active],
      created_at: DateTime.now, updated_at: DateTime.now
    }
    @user = User.new(user)
  end

  def process_update(id)
    @user = User.find_by_id(id)
    @user.user_image = @fname
    updated_values = {
      user_image: @fname,
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name], is_active: params[:user][:is_active],
      biography: params[:user][:biography], updated_at: DateTime.now
    }
    @user.update(updated_values)
  end

  def add_role(role_id, user_id)
    if check_role(role_id)
      @error = 'User has role already'
      false
    else
      UserRole.create(
        user_id: user_id, role_id: role_id, is_active: true
      )
      true
    end
  end

  def check_role(role_id)
    @user_role = UserRole.where(
      user_id: session[:user_id], role_id: role_id,
      is_active: true
    ).first
    return true if @user_role
    false
  end

  def get_role_by_id(record_id)
    @user_role = UserRole.where(
      id: record_id
    ).first
  end

  def edit_role(role_id, record_id)
    get_role_by_id(record_id)
    @user_role.update(role_id: role_id)
    @user_role.save
  end

  def save_process(typeprocess, page_redirect, page_redirect_error)
    if @user.save
      session[:user_id] = @user.id
      if typeprocess == 'Add'
        add_role(3, @user.id)
        flash[:success] = 'Profile successfully created!'
        construct_new_mail_send(@user.email, @user.first_name, @user.last_name)
      else
        flash[:success] = 'Profile successfully updated!'
      end
      redirect to page_redirect
    else
      flash[:error] = @user.errors.full_messages
      redirect to page_redirect_error
    end
  end

  
end
