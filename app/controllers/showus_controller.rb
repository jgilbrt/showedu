class ShowusController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # Shows ShowUs where current_user is sender or receiver
    @showus = Showu.where("user_id = ? OR receiver_id = ?", current_user.id, current_user.id)
                   .order(created_at: :desc)
  end

  def new
    @showu = Showu.new
  end

  def create
  @showu = current_user.showus.build(showu_params)

  # Optional: Fetch poster from TMDb if a URL is provided
  if @showu.tmdb_poster_path.present?
    movie_id = extract_tmdb_id(@showu.tmdb_poster_path)
    if movie_id
      poster_path = fetch_tmdb_poster_path(movie_id)
      @showu.tmdb_poster_path = poster_path if poster_path
    end
  end

  receiver = User.find(showu_params[:receiver_id])
  unless current_user.following.include?(receiver)
    flash.now[:alert] = "You can only show content to users you follow."
    render :new and return
  end

  if @showu.save
    redirect_to showus_path, notice: "ShowU posted successfully!"
  else
    render :new, alert: "Oops, something went wrong."
  end
end



  private

def showu_params
params.require(:showu).permit(:description, :receiver_id, :youtube_url, :image_url, :spotify_url, :tmdb_poster_path)
end

def extract_tmdb_id(url)
  match = url.match(/\/movie\/(\d+)/)
  match[1] if match
end

def fetch_tmdb_poster_path(movie_id)
  api_key = "b7ada0ccd057c65a7ac78e759bec7c90" # your key
  response = HTTParty.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}")
  return nil unless response.success?

  response.parsed_response["poster_path"]
end

end
