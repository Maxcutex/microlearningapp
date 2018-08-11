# Migration to create course details table
class CreateCourseDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :course_details do |t|
      t.integer :day_number, :default => 0
      t.string :day_topic
      t.string :day_details
      t.integer :course_id
      t.string :topic_image
      t.string :topic_thumbnail
    end
  end
end
