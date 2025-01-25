module V0
  module UsersFavoriteBookSerializer
    class BookModel < V0::ApplicationSerializer::Model
      attributes :id, :title, :description, :public_url, :author

      attribute(:created_at) { object.created_at.as_json }
      attribute(:updated_at) { object.updated_at.as_json }

      def author
        return if object.author.nil?

        ::V0::AuthorSerializer::Model.new(object.author)
      end
    end
  end
end
