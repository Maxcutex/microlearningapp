FactoryBot.define do
  factory :user_learnt_track, class: 'UserLearntTrack' do
    day_number
    next_day_number { day_number + 1}
    association :user_enrollments, factory: :user_enrollments
  end
end
