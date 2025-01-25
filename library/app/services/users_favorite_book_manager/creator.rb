module UsersFavoriteBookManager
  class Creator < ApplicationManager::Creator

    attr_reader :user, :args

    def initialize(user, args)
      @user = user
      @args = args
    end

    private

    def execute_creation
      validate!
      save!
    end

    def validate!
      return if user.kind.to_sym == ::User::READER

      raise Exceptions::AccessNotAllowedError
    end

    def save!
      users_favorite_book = UsersFavoriteBook.new(book_id: args[:book_id], user_id: user.id)
      users_favorite_book.save!
      users_favorite_book.reload
    end
  end
end

