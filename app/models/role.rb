# Role Model
class Role < ActiveRecord::Base
  validates :role_name, :role_description, presence: true

end
