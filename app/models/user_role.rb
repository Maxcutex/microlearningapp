# Model for User Enrollment
class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  validates :user_id, :role_id, :is_active, presence: true

  def self.get_by_user_id(user_id)
    where(user_id: user_id).first
  end
end
