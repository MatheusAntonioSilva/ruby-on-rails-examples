class UsersFavoriteBook < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, presence: true, uniqueness: true
end
