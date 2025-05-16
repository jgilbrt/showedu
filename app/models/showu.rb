class Showu < ApplicationRecord
  belongs_to :user  # sender
  belongs_to :receiver, class_name: 'User'  # the person you're showing it to

  include ActionView::Helpers::DateHelper

  validates :receiver, presence: true
  validate :at_least_one_media_url_present

  def display_text
    "#{user.username} showed #{receiver.username} #{description} #{time_ago_in_words(created_at)} ago"
  end

  # Return YouTube video ID from youtube_url
  def youtube_id
    return nil unless youtube_url.present?
    # Matches v=xxxx or be/xxxx part of YouTube URLs
    youtube_url[/((?<=v=)[\w-]+)|((?<=be\/)[\w-]+)/]
  end

  # TMDb poster full URL helper, if you store poster_path
  def tmdb_poster_url
    return nil unless tmdb_poster_path.present?
    "https://image.tmdb.org/t/p/w500/#{tmdb_poster_path}"
  end

  private

  # Custom validation to ensure at least one media URL is present
 def at_least_one_media_url_present
  if youtube_url.blank? && image_url.blank? && spotify_url.blank? && tmdb_poster_path.blank?
    errors.add(:base, "Please provide at least one media link (YouTube, Image, Spotify, or TMDB).")
  end
end

end
