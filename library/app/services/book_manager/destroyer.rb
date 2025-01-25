module BookManager
  class Destroyer < ApplicationManager::Destroyer

    attr_reader :user

    def initialize(id, user)
      super(id)
      @user = user
    end

    def destroy
      validate!
      super()
    end

    private

    def validate!
      return if user.kind.to_sym == ::User::LIBRARIAN

      raise Exceptions::AccessNotAllowedError
    end

    def instance
      ::Book.find(id)
    end
  end
end
