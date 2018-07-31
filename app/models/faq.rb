# FAQ Model
class FAQ < ActiveRecord::Base
  validates :faq_title, :faq_description, presence: true
end
