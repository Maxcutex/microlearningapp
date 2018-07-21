# Create course category table
class CreateCourseCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :course_categories do |t|
      t.string :category_name
      t.boolean :is_active
    end
  end
end
