# Model for User learnt tracks
class UserLearntTrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :course_details

  validates :notes, presence: true
end
