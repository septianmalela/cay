class User::FollowsController < ApplicationController
  before_action :set_user

  def follow
    current_user.followees << @user
    redirect_to root_path, notice: "Followeed #{@user.username}"
  end

  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to root_path, alert: "Unfollow #{@user.username}"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end