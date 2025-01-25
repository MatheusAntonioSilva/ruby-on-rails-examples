class Author < ApplicationRecord

  belongs_to :user
  has_many :books

  validates :name, :user_id, presence: true
end
