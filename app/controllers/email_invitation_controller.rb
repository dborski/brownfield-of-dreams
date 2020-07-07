class EmailInvitationController < ApplicationController
  def new;end

  def create
    github_handle = params[:github_handle]

    email_info = { user_token: current_user.github_token,
                   app: "Brownfield of Dreams",
                 }

    if InvitationMailer.invite(email_info, github_handle).deliver_now == nil
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    else 
      flash[:notice] = "Successfully sent invite!"
    end

    redirect_to dashboard_path
  end 
end
