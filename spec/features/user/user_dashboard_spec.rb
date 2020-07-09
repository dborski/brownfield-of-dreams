require 'rails_helper'

RSpec.describe 'user dashboard show page', type: :feature do
  describe 'As a user' do
    before(:each) do

      @user = create(:user)

      @tutorial1 = create(:tutorial)
      @tutorial2 = create(:tutorial)
      @tutorial3 = create(:tutorial)

      @video1 = create(:video, tutorial: @tutorial1, position: 2)
      @video2 = create(:video, tutorial: @tutorial2, position: 1)
      @video3 = create(:video, tutorial: @tutorial3, position: 3)
      @video4 = create(:video, tutorial: @tutorial3, position: 4)

      UserVideo.create!(user: @user, video: @video1)
      UserVideo.create!(user: @user, video: @video2)
      UserVideo.create!(user: @user, video: @video3)
      UserVideo.create!(user: @user, video: @video4)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path
    end

    it "page has Github section", :vcr do
      expect(page).to have_css(".github")
      expect(page).to have_content("Github Repositories")
    end

    it "can see the name of five of my repositories with links to their repos on github", :vcr do
      within(".github") do
        expect(page).to have_css(".repo", count: 5)
        within(first(".repo")) do
          expect(page).to have_css(".repo-link")
        end 
      end
    end

    it "can see all of my bookmarked segments", :vcr do
      within(".bookmarked") do
        expect(page).to have_css(".tutorial", count: 3)
        within(first(".tutorial")) do
          expect(page).to have_css(".tutorial-video", count: 1)
        end 
      end
    end
  end 
end 
