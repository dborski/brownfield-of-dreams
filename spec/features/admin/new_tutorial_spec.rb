require 'rails_helper'

RSpec.describe 'New tutorial', type: :feature do
  describe 'As an admin' do
    before(:each) do

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'
    end

    it "can create new tutorial by entering youtube playlist ID into form", :vcr do
      click_link "Import YouTube Playlist"
      
      expect(current_path).to eq('/admin/tutorials/new')

      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"

      fill_in 'Playlist ID', with: id
      click_button 'Import Playlist'

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content('Successfully created tutorial. View it here')
      
      click_link 'View it here'

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
