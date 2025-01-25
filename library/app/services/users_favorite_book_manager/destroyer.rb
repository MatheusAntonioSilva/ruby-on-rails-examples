module UsersFavoriteBookManager
  class Destroyer < ApplicationManager::Destroyer

    attr_reader :user

    def initialize(user, id)
      @user = user
      super(id)
    end

    private

    def instance
      ::UsersFavoriteBook.find_by!(book_id: id, user_id: user.id)
    end
  end
end
