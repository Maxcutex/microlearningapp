# Model for User learnt tracks
class UserLearntTrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :course_details

  has_one :user, class_name: 'User', foreign_key: 'user_id'
  has_one :course, class_name: 'Course', foreign_key: 'course_id'

  validates :notes, presence: true
end
