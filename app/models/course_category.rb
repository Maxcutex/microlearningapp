# Model for course category
class CourseCategory < ActiveRecord::Base
  has_many :courses, class_name: 'Course'
  validates :category_name, presence: true

  def self.all_categories
    order(:id)
  end

  def self.get_category_by_id(id)
    where(id: id).first
  end
end
