require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe "instruction" do
    it 'renders the subject and to field' do
      email_info = { user_token: ENV['DEREK_GITHUB_TOKEN'],
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
