class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :showu

  validates :body, presence: true
end
