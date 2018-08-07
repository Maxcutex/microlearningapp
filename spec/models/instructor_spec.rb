require 'spec_helper'
describe User, type: :model do
  before do
    @user1 = create(:user_instructor)
  end

  it 'is valid with valid attributes' do
    expect(@user1).to be_valid
  end

  it 'has a role instructor' do
    user2 = build(:user_instructor, email: 'bob@gmail.com')
    expect(user2).to be_valid
  end
end
