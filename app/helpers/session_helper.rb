# Module for handling session variables
module SessionHelpers
  def logged_in?
    !!current_user
  end

  def is_admin?
    !!confirm_admin
  end

  def is_instructor?
    !!confirm_instructor
  end

  # Find current user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  # Confim if user is admin
  def confirm_admin
    @confirm_admin ||= UserRole.where('role_id = ? AND user_id = ? AND is_active = ?', 1, session[:user_id], true).first
  end

  # confirm if user is an instructor
  def confirm_instructor
    @confirm_instructor ||= UserRole.where('role_id = ? AND user_id = ? AND is_active = ?', 2, session[:user_id], true).first
  end

  # Find a course based on id
  def find_course(id)
    @course ||= Course.find_by_id(id)
  end

  # Display course difficulty based on level
  def course_difficulty(num)
    case num
    when 0
      'Easy'
    when 1
      'Intermediate'
    else
      'Advanced'
    end
  end

  # Display course registration status based on confirmation
  def registration_status(num)
    case num
    when 0
      'Pending'
    when 1
      'Waitlisted'
    else
      'Enrolled'
    end
  end
end
