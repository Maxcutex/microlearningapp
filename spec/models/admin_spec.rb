require 'spec_helper'
describe User, type: :model do
  before do
    @user1 = create(:user_admin)
  end

  it 'is valid with valid attributes' do
    expect(@user1).to be_valid
  end

  it 'has a role student' do
    user2 = build(:user_admin, email: 'bob@gmail.com')
    expect(user2).to be_valid
  end
end
