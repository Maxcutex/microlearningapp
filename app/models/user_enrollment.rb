# Model for User Enrollment
class UserEnrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :notes, presence: true

  def self.get_enrollment(user_id, course_id)
    where(user_id: user_id, course_id: course_id).first
  end

  def self.get_active_enrollment(user_id, course_id)
    where(
      user_id: user_id,
      course_id: course_id,
      is_active: true
    ).first
  end

  def self.get_by_user_id(user_id)
    where(user_id: user_id)
  end

  def self.active_user_enrollment(user_id)
    where(user_id: user_id, is_active: true)
  end
end
