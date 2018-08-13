# Model for Course
class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  belongs_to :course_category, class_name: 'CourseCategory', foreign_key: 'category_id'

  validates :instructor_id, :name, :level, :category_id, presence: true

  def self.all_courses
    order(:id)
  end

  def self.active_courses
    where(is_active: true)
  end

end
