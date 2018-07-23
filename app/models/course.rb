# Model for Course
class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  belongs_to :coursecategory, class_name: 'CourseCategory', foreign_key: 'category_id'

  validates :instructor_id, :name, :description, :level, :category_id, presence: true
end
