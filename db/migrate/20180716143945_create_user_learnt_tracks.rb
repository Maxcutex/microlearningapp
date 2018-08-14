# Migration to show learnt tracks by user 158983359
class CreateUserLearntTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_learnt_tracks do |t|
      t.integer :day_number
      t.integer :next_day_number
      t.integer :user_enrollment_id
    end
  end
end
