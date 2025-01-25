module V0
  module BookSerializer
    class Model < V0::ApplicationSerializer::Model
      attributes :id, :title, :description, :public_url, :user, :author

      attribute(:created_at) { object.created_at.as_json }
      attribute(:updated_at) { object.updated_at.as_json }

      def user
        return if object.user.nil?

        ::V0::UserSerializer::Model.new(object.user)
      end

      def author
        return if object.author.nil?

        ::V0::AuthorSerializer::Model.new(object.author)
      end
    end
  end
end
