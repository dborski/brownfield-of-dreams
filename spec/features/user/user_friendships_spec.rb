require "rails_helper"

describe "As a registered user with a github token", :vcr do
  before :each do
    @user1 = create(:user, github_token: ENV['GITHUB_TOKEN1'], github_username: 'Shock253', github_id: 28197446)
    @user2 = create(:user, github_token: ENV['GITHUB_TOKEN2'], github_username: 'dborski', github_id: 60106123)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    visit '/dashboard'
  end

  it "buttons to friend users show up on dashboard" do
    within ".followed-dborski" do
      expect(page).to have_button('Add as Friend')
    end

    within ".follower-dborski" do
      expect(page).to have_button('Add as Friend')
    end

    within ".follower-alex-latham" do
      expect(page).to_not have_button('Add as Friend')
    end
  end

  xit "I can add friends" do
    within ".follower-dborski" do
      expect(page).to have_button('Add as Friend')
      click_button 'Add as Friend'
    end

    expect(current_path).to eq('/dashboard')

    within ".follower-dborski" do
      expect(page).to_not have_button('Add as Friend')
    end

    expect(page).to have_content("#{@user2.first_name} #{@user2.last_name}")

  end
end
