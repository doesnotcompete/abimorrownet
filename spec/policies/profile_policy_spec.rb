require 'spec_helper'

describe ProfilePolicy do

  let(:user) { build(:user) }
  let(:admin) { build(:admin) }

  subject { ProfilePolicy }

  permissions :create? do
    it { is_expected.to permit(admin, build(:profile)) }
    it { is_expected.to permit(user, build(:profile, user: user)) }
  end

  permissions :show? do
    it { is_expected.to permit(user, build(:profile)) }
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
