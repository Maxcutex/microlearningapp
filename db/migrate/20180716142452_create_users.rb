# Migration for Creating Users
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :biography
      t.boolean :is_active
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
