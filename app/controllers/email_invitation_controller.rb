class EmailInvitationController < ApplicationController
  def new;end

  def create
    github_handle = params[:github_handle]

    email_info = { user_token: current_user.github_token,
                   app: "Brownfield of Dreams",
                 }

    if InvitationMailer.invite(email_info, github_handle).deliver_now
      flash[:notice] = "Successfully sent invite!"
    else 
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end

    redirect_to dashboard_path
  end 
end
