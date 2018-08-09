# Role Model
class Role < ActiveRecord::Base
  validates :role_name, :role_description, presence: true

  def self.get_by_id(id)
    where(id: id).first
  end
end
