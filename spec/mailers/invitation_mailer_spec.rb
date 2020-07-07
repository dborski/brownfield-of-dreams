require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe "instruction" do
    it 'renders the subject and to field' do
      user = create(:user, github_token: "ef13805069edcaca737c7aa6e66442ee8f96cf99")
      email_info = { user_token: user.github_token,
        app: "Brownfield of Dreams",
      }
      github_handle = "dborski"
      
      InvitationMailer.invite(email_info, github_handle).deliver_now 

      activation_email = ActionMailer::Base.deliveries.last

      expect(activation_email.subject).to eq("Brownfield of Dreams Invitation")
      expect(activation_email.to.first).to eq("derek.borski@gmail.com")
    end
  end 
end
