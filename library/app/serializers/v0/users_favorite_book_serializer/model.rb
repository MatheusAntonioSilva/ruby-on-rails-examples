module V0
  module UsersFavoriteBookSerializer
    class Model < V0::ApplicationSerializer::Model
      attributes :id, :user, :book

      attribute(:created_at) { object.created_at.as_json }
      attribute(:updated_at) { object.updated_at.as_json }

      def user
        return if object.user.nil?

        ::V0::UserSerializer::Model.new(object.user)
      end

      def book
        return if object.book.nil?

        ::V0::UsersFavoriteBookSerializer::BookModel.new(object.book)
      end
    end
  end
end
