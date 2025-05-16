class ShowusController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @showus = Showu.all.order(created_at: :desc)
  end

  def new
    @showu = Showu.new
  end

  def create
    @showu = current_user.showus.build(showu_params)
    if @showu.save
      redirect_to showus_path, notice: "ShowU posted successfully!"
    else
      render :new, alert: "Oops, something went wrong."
    end
  end

  private

def showu_params
  params.require(:showu).permit(:description, :youtube_url, :image_url, :receiver_id)
end

end
