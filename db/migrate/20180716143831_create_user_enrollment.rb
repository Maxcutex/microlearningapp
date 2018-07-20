# Migration for creating user enrollment table
class CreateUserEnrollment < ActiveRecord::Migration[5.2]
  def change
    create_table :user_enrollments do |t|
      t.integer :confirmation, :default => 0
      t.string :notes
      t.integer :user_id
      t.integer :course_id
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_active
    end
  end
end
