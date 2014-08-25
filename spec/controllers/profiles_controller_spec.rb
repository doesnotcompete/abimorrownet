require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do
  login_user

  profile = FactoryGirl.create(:profile)

  describe "#show" do
    context "when the profile does not exist" do
      subject { get "show", id: 123 }
      it { is_expected.to redirect_to(root_url) }
    end

    context "when the profile does exist" do
      subject { get "show", id: profile.id }
      it { is_expected.to render_template :show }

      context "when json is requested" do
        subject { get "show", id: profile.id, format: :json }
        it { is_expected.to be_success }
      end
    end
  end

  describe "#index" do
    context "when public profiles do exist" do
      subject { get "index" }
      let(:body) { response.body }
      it { is_expected.to render_template :index }
    end
  end

  describe "#update" do
    login_admin
    context "when the profile does not exist" do
      subject { get "edit", id: 123 }
      it { is_expected.to redirect_to(root_url) }
    end
    context "when the profile does exist" do
      subject { get "edit", id: profile.id }
      it { is_expected.to render_template :edit }
    end
  end

  describe "#patch" do
    context "when the patched profile does exist" do
      pending
    end
  end
end
