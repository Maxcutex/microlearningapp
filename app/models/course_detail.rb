# Model for course details
class CourseDetail < ActiveRecord::Base
  belongs_to :course

  validates :day_number, :day_topic, :day_details, :course_id, presence: true

  def self.all_courses
    order(id: id)
  end

  def self.get_by_id(id)
    where(id: id).first
  end

  def self.course_details_by_course_id(course_id)
    where(course_id: course_id).order(:day_number)
  end

  def self.get_by_detail_id(detail_id)
    where(detail_id: detail_id).first
  end

  def self.get_last(course_id)
    where(course_id: course_id).order(day_number).last
  end

  def self.get_existing(day_number, course_id)
    where(course_id: course_id, day_number: day_number).first
  end
end
