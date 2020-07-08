class UsersController < ApplicationController
  def show; end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      AccountConfirmationMailer.confirm_account(user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    if params[:activate] == "true"
      user = User.find(params[:user_id])
      user.activated = true
      if user.save
        flash[:notice] = "Thank you! Your account is now activated."
      end
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
