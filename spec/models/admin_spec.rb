require 'spec_helper'
describe User, type: :model do
  before do
    @user1 = create(:administrator)
  end

  it 'is valid with valid attributes' do
    expect(@user1).to be_valid
  end
end
