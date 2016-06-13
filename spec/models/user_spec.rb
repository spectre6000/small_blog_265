require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid model' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a username' do
    expect(
      build(:user, username: nil, bio: nil, email: 'username@email.com')
    ).to_not be_valid
  end

  it 'is invalid without an email address' do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it 'returns confirmed users with the confirmed_users scope' do
    unconfirmed = create(:user, confirmed_at: nil)
    confirmed = create(:user)

    expect(User.confirmed_users).to match_array([confirmed])
  end
end
