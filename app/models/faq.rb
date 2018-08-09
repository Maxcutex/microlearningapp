# FAQ Model
class FAQ < ActiveRecord::Base
  validates :faq_title, :faq_description, presence: true

  def self.all_faqs
    order(id: id)
  end

  def self.get_by_id(id)
    where(id: id).first
  end
end
