# Model for User learnt tracks
class UserLearntTrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :course_detail

  has_one :user, class_name: 'User', foreign_key: 'user_id'
  has_one :course, class_name: 'Course', foreign_key: 'course_id'

  validates :notes, presence: true

  def self.get_by_id(id)
    where(id: id).first
  end

  def self.get_by_user_id(user_id, course_id)
    where(user_id: id, course_id: course_id)
  end

  def self.get_last_track_by_user_id(user_id, course_id)
    where(user_id: id, course_id: course_id).order(:day_number).last
  end
end
