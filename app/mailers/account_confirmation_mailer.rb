class AccountConfirmationMailer < ApplicationMailer
  def confirm_account(user)
    @user = user
    @link = url_for( controller:'activation', action:'activate', host: ENV['HOST'])
    mail(
      to: user.email,
      subject: "Brownfield of Dreams Account Activation"
    )
  end
end
