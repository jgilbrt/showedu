class AddSpotifyUrlToShowus < ActiveRecord::Migration[7.1]
  def change
    add_column :showus, :spotify_url, :string
  end
end
