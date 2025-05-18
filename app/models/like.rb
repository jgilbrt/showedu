class Like < ApplicationRecord
  belongs_to :user
  belongs_to :showu

  validates :user_id, uniqueness: { scope: :showu_id } # user can like a showu only once
end
