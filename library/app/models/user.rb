class ::User < ::ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher

  LIBRARIAN = :librarian
  READER = :reader

  has_many :books
  has_many :authors
  has_many :users_favorite_books

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :password_confirmation, presence: true, on: :create
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :eula, acceptance: { accept: [::User::LIBRARIAN, ::User::READER] }
end
