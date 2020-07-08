require "rails_helper"

describe "User" do
  it "User can see followers while logged in", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within ".followers" do
      expect(page).to have_css(".follower", count: 3)
      within(first(".follower")) do
        expect(page).to have_css(".name")
      end
    end
  end
end
