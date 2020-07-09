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

  it "I can add friends" do
    within ".follower-dborski" do
      expect(page).to have_button('Add as Friend')
      click_button 'Add as Friend'
    end

    expect(current_path).to eq('/dashboard')

    within ".follower-dborski" do
      expect(page).to_not have_button('Add as Friend')
    end


    within ".friend-#{@user2.id}" do
      expect(page).to have_content("#{@user2.first_name} #{@user2.last_name}")
    end
  end
end

# As a registed user with a github token
# visit '/dashboard'
# next to a follower that is in the system
# I should see a link to add them as a friend
# I should not see a link next to a follower that is not in the system
# when I click on add friend
# then a friendship relationship is created
# and I should see that friend in my 'friendships' section
# and I should no longer see add as friend next to their name

# Background: A user (Josh) exists in the system with a Github token. The user has two followers on Github. One follower (Dione) also has an account within our database. The other follower (Mike) does not have an account in our system. If a follower or following has an account in our system we want to include a link next to their name to allow us to add as a friend.
#
# In this case Dione would have an Add as Friend link next to her name. Mike would not have the link next to his name.
#
# Tips: No need to work on edge cases during your spike. You'll want to research self referential has_many through. Here's a good starting point to understand the concept: http://blog.hasmanythrough.com/2007/10/30/self-referential-has-many-through. You'll probably need to do more googling but that's part of the fun ;)
#
#  Links show up next to followers that have accounts in our system.
#  Links show up next to followings that have accounts in our database.
#  Links do not show up next to followers or followings if they are not in our database.
#  There's a section on the dashboard that shows all of the users that I have friended
#  Edge Case: Make sure this fails gracefully. If you open up a POST route to create a friendship, be sure to catch the scenario where someone sends an invalid user id. Send a flash message alerting them of the error.
