class FriendshipsController < ApplicationController
  protect_from_forgery prepend: true

  def create
    friend = User.find_by(github_id: params[:github_id])
    user = User.find(params[:user_id])
    Friendship.create(friend_id: friend.id, user_id: user.id)
    redirect_to dashboard_path
  end
end
