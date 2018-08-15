# Migration for creating courses table
class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.integer :level
      t.integer :instructor_id
      t.integer :no_days
      t.integer :category_id
      t.boolean :is_active
    end
  end
end
