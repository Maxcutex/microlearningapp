FactoryBot.define do
  factory :faq, class: 'FAQ' do
    faq_title { Faker::Lorem.sentences(1) }
    faq_description { Faker::Lorem.paragraph(2, true, 4)}
  end
end
