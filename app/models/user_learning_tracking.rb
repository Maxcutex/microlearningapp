# Model for User learnt tracks
class UserLearntTrack < ActiveRecord::Base
  belongs_to :user_enrollments, class_name: "UserEnrollment", foreign_key: "user_enrollment_id"

  def self.get_by_id(id)
    where(id: id).first
  end

  def self.get_by_user_id(user_id, course_id)
    joins(:user_enrollments).where(user_enrollments: { user_id: user_id, course_id: course_id })
  end

  def self.get_last_track_by_user_id(user_id, course_id)
    joins(:user_enrollments).where(user_enrollments: { user_id: user_id, course_id: course_id })
    .order(:day_number).last
  end
end
