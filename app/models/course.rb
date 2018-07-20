# Model for Course
class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  belongs_to :course_category, class_name: 'CourseCategory'
  validates :instructor_id, :name, :description, :level, :category_id, presence: true
end
