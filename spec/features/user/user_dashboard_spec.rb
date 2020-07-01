require 'rails_helper'

RSpec.describe 'user dashboard show page', type: :feature do
  describe 'As a user' do
    before(:each) do

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
    end

    it "page has Github section" do
      expect(page).to have_css(".github")
      expect(page).to have_content("Github Repositories")
    end

    it "can see the name of five of my repositories with links to their repos on github" do
      within(".github") do
        expect(page).to have_css(".repo", count: 5)
        within(first(".repo")) do
          expect(page).to have_css(".repo-link")
        end 
      end
    end
  end 
end 
