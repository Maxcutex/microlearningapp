# Model for course details
class CourseDetails < ActiveRecord::Base
  belongs_to :course

  validates :day_number, :day_topic, :day_details, :course_id, presence: true
end
