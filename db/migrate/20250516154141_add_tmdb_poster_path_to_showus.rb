class AddTmdbPosterPathToShowus < ActiveRecord::Migration[7.1]
  def change
    add_column :showus, :tmdb_poster_path, :string
  end
end
