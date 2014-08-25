require "rails_helper"

RSpec.describe "profiles/show.html.erb", driver: :selenium do
  it "displays the profile" do
    pending
    profile_f = FactoryGirl.build(:profile, :female)
    assign(:profile, profile_f)

    render

    expect(rendered).to include(profile_f.first_name)
  end
end
