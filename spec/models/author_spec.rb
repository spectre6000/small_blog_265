require 'rails_helper'

RSpec.describe Author, type: :model do
  
  it 'has a valid model' do
    expect(build(:author)).to be_valid
  end

  it 'is invalid without a username' do
    expect(build(:author, username: nil)).to_not be_valid
  end

  it 'is invalid without an email address' do
    expect(build(:author, email: nil)).to_not be_valid
  end

end
