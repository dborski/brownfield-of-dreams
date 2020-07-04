require 'rails_helper'

RSpec.describe 'New tutorial', type: :feature do
  describe 'As an admin' do
    before(:each) do

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'
    end

    it "can create new tutorial by entering youtube playlist ID into form" do
      click_link "Import YouTube Playlist"
      
      expect(current_path).to eq('/admin/tutorials/new')

      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"

      fill_in 'Playlist ID', with: id
      click_button 'Import Playlist'

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content('Successfully created tutorial. View it here.')
      
      click_link 'View it here.'

      new_tutorial = Tutorial.last

      expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

      within(".tutorials") do
        expect(page).to have_css(".playlist_video")
        within(first(".playlist_video")) do
          expect(page).to have_css(".show-link")
        end 
      end
    end
  end 
end 
# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form

# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube