class Showu < ApplicationRecord
  belongs_to :user  # sender
  belongs_to :receiver, class_name: 'User'  # the person you're showing it to

  def display_text
    "#{user.name} showed #{receiver.name} #{description} #{time_ago_in_words(created_at)} ago"
  end
end
