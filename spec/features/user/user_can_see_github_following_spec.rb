require "rails_helper"

describe "User" do
  it "User can see following while logged in", :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within ".following" do
      expect(page).to have_css(".followed", count: 1)
      within(first(".followed")) do
        expect(page).to have_css(".name")
      end
    end
  end
end
