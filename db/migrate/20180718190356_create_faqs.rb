class CreateFaqs < ActiveRecord::Migration[5.2]
  def change
    create_table :faqs do |t|
      t.string :faq_title
      t.string :faq_description
    end
  end
end
