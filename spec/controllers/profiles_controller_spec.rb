require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do
  login_user

  describe "on GET show" do
    context "when the profile does not exist" do
      subject { get "show", id: 123 }
      it { is_expected.to redirect_to(root_url) }
    end

    context "when the profile does exist" do
      profile = FactoryGirl.create(:profile)
      subject { get "show", id: profile.id }
      it { is_expected.to render_template :show }
    end
  end
end
