class ::Book < ApplicationRecord

  BUCKET = 'library-app-files'.freeze

  belongs_to :user
  belongs_to :author
  has_many :users_favorite_books

  validates :title, :description, :public_url, :user_id, :author_id, :file_name, presence: true
end
