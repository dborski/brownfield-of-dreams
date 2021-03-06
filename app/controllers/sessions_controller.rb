class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    if params[:provider] == 'github'
      current_user.github_token = auth_hash['credentials']['token']
      current_user.github_username = auth_hash['extra']['raw_info']['login']
      current_user.github_id = auth_hash['extra']['raw_info']['id']
      current_user.save
    end
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
