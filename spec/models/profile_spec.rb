require 'rails_helper'

RSpec.describe Profile, :type => :model do
  it "should be invalid without a name" do
    expect(subject).not_to be_valid
  end
  it "should be valid with a name" do
    profile = build(:profile)
    expect(profile).to be_valid
  end
end
