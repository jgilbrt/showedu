class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow, :update_avatar]

  def show
    @user = User.find_by(username: params[:username])
    if @user.nil?
      redirect_to root_path, alert: "User not found"
      return
    end

    @showus = @user.showus.order(created_at: :desc)
    @followers = @user.followers
    @following = @user.following
  end

  def search
    @users = if params[:query].present?
               User.where("username ILIKE ?", "%#{params[:query]}%").limit(10)
             else
               []
             end

    respond_to do |format|
      format.html
      format.json { render json: @users.select(:username) }
    end
  end

  def follow
    user_to_follow = User.find_by(username: params[:username])
    if user_to_follow && current_user != user_to_follow
      current_user.following << user_to_follow unless current_user.following.include?(user_to_follow)
      redirect_to user_path(user_to_follow.username), notice: "You are now following #{user_to_follow.username}."
    else
      redirect_back fallback_location: root_path, alert: "Unable to follow user."
    end
  end

  def unfollow
    user_to_unfollow = User.find_by(username: params[:username])
    if user_to_unfollow && current_user.following.include?(user_to_unfollow)
      current_user.following.delete(user_to_unfollow)
      redirect_to user_path(user_to_unfollow.username), notice: "You unfollowed #{user_to_unfollow.username}."
    else
      redirect_back fallback_location: root_path, alert: "Unable to unfollow user."
    end
  end

def update_avatar
  @user = User.find_by!(username: params[:username])

  # Check current user owns this profile and file is uploaded
  if @user == current_user && params.dig(:user, :avatar).present?
    @user.avatar.purge if @user.avatar.attached? # optional: remove old avatar

    @user.avatar.attach(params[:user][:avatar]) # attach new avatar

    if @user.avatar.attached?
      redirect_to user_path(@user.username), notice: "Profile image updated."
    else
      redirect_to user_path(@user.username), alert: "Failed to attach the image."
    end
  else
    redirect_to user_path(@user.username), alert: "You can only update your own profile image and must provide a file."
  end
end

end
