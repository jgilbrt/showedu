class UsersController < ApplicationController

  def show
@user = User.find(params[:id])
    if @user.nil?
      redirect_to root_path, alert: "User not found"
      return
    end

    @showus = @user.showus.order(created_at: :desc)
    @followers = @user.followers
    @following = @user.following
  end

  def search
    if params[:query].present?
      @users = User.where("username ILIKE ?", "%#{params[:query]}%")
    else
      @users = []
    end
  end

end
