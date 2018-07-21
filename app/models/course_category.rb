# Model for course category
class CourseCategory < ActiveRecord::Base
  has_many :courses, class_name: 'Course'
  validates :category_name, :is_active, presence: true
end
