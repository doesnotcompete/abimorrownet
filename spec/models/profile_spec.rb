require 'rails_helper'

RSpec.describe Profile, :type => :model do
  context "when it does not have a name" do
    it { is_expected.to be_invalid }
  end

  context "when it has a name" do
    subject { build(:profile) }
    it { is_expected.to be_valid }
  end
end
