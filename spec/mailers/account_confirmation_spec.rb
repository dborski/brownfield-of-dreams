require "rails_helper"

RSpec.describe AccountConfirmationMailer, type: :mailer do
  def get_message_part(mail, content_type)
    mail.body.parts.find { |p| p.content_type.match content_type }.body.raw_source
  end

  describe "account confirmation email" do
    it "Sends an email with a link to user for activation" do
      user = create(:user, github_token: ENV["GITHUB_API_KEY"])

      AccountConfirmationMailer.confirm_account(user).deliver_now

      activation_email = ActionMailer::Base.deliveries.last
      email = Capybara::Node::Simple.new(get_message_part(activation_email, /html/))

      url = url_for( controller:'activation', action:'activate' )
      expect(email).to have_link('Visit here to activate your account.', href: url)
    end
  end
end
