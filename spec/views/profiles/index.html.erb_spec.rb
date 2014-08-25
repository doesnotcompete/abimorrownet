require "spec_helper"

describe "profiles/index.html.erb", driver: :selenium do
  it "displays all the profiles" do
    pending
    profile_m = FactoryGirl.build(:profile, :male)
    profile_f = FactoryGirl.build(:profile, :female)
    assign(:profiles, [
      profile_m,
      profile_f
    ])

    render

    expect(rendered).to include(profile_m.first_name)
    expect(rendered).to include(profile_f.first_name)
  end
end
