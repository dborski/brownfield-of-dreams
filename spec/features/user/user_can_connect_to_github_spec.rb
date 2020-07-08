require "rails_helper"

describe "User" do
  it "User can see followers while logged in", :vcr do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        'provider' => 'github',
        'credentials' => {'token' => ENV['GITHUB_API_KEY']},
        'extra' => {
          'raw_info' => {
            'login' => 'johndoe'
          }
        }
      })

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.github_token = nil
    user.save

    visit "/dashboard"

    click_on "Connect to Github"

    within ".github" do
      expect(page).to have_css(".followers")
    end

    OmniAuth.config.mock_auth[:github] = nil
  end
end
