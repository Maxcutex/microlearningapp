# create roles model
class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role_name
      t.string :role_description
    end
  end
end
