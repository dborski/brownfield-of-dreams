class AccountConfirmationMailer < ApplicationMailer
  def confirm_account(user)
    @user = user
    mail(
      to: user.email,
      subject: "Brownfield of Dreams Account Activation"
    )
  end
end
