class InvitationMailer < ApplicationMailer
  def invite(info, handle)
    invitee_info = GithubService.new.get_user_info(handle, info[:user_token])
    inviter_info = GithubService.new.get_authenticated_user_info(info[:user_token])

    @invitee_name = invitee_info[:login]
    @inviter_name = inviter_info[:login]
    @app_name = info[:app]

    # binding.pry
    
    if invitee_info[:email]
      mail(to: invitee_info[:email], subject: "#{@app_name} Invitation")
    else
      "No email"
    end 
  end
end
