require 'rails_helper'

RSpec.describe 'user dashboard show page', type: :feature do
  describe 'As a user' do
    before(:each) do

      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path
    end

    it "I can send an e-mail invite through the user dashboard" do
      click_link "Send an Invite"
      
      expect(current_path).to eq('/invite')
      
      fill_in 'Github Handle:', with: "dborski"
      click_button "Send Invite"
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end

    xit "Send e-mail fails if github user does not have an e-mail address" do
      click_link "Send an Invite"
      
      expect(current_path).to eq(invite_path)
      
      fill_in 'Github Handle', with: "random121212d"
      click_button "Send Invite"
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end 
end 

# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite

# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email
# address associated with their github account)
# Or I should see a message that says "The Github user you selected 
# doesn't have an email address associated with their account."