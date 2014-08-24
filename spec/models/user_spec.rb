require 'rails_helper'

RSpec.describe User, :type => :model do
  it "should be invalid without an email" do
    expect(subject).not_to be_valid
  end
  it "should be valid with an email" do
    user = build(:user)
    expect(user).to be_valid
  end

  context "with an associated account" do
    let(:user) { build(:identified_user) }
    it "should be valid" do
      expect(user).to be_valid
    end
    it "should have an identity" do
      expect(user.has_identity?).to be_truthy
    end
    it "should loose its identity on #remove_association" do
      user.remove_association
      expect(user.has_identity?).to be_falsey
    end
  end
end
