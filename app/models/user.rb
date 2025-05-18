class User < ApplicationRecord
  has_many :showus, dependent: :destroy

  # Follow associations:
  # These keep track of who follows the user (followers)
  has_many :follower_relationships, foreign_key: :followed_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower

  # These keep track of who the user follows (following)
  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow"
  has_many :following, through: :following_relationships, source: :followed

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :avatar


   def follow(other_user)
    following << other_user unless self == other_user || following.include?(other_user)
  end

  # Unfollow a user
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Check if following a user
  def following?(other_user)
    following.include?(other_user)
  end


  def user_params
  params.require(:user).permit(:avatar_url, :other, :fields)
end


end
