require 'rails_helper'

RSpec.describe 'user dashboard show page', type: :feature do
  describe 'As a user' do
    before(:each) do

      user = create(:user)
      repos = user.user_repos(5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
    end

    it "page has Github section" do
      expect(page).to have_css(".github")
      expect(page).to have_content("Github Repositories")
    end

    xit "can see the name of five of my repositories with links to their repos on github" do
      within("#order-#{@order1.id}") do
        expect(page).to have_link("Order #{@order11.id}")
      end
    end
  end 
end 
