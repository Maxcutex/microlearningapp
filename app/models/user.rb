# User Model
class User < ActiveRecord::Base
  has_secure_password
  has_many :courses
  has_many :userEnrollments
  has_many :userLearntTracks
  has_one :userrole, class_name: 'UserRole', foreign_key: 'user_id'

  validates :first_name, :last_name, presence: true
  # validates_uniqueness_of :username, :email, case_sensitive: false
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
