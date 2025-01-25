module V0
  module BookSerializer
    class ListResource < ::V0::ApplicationSerializer::ListResource
      attribute :pagination

      has_many(:data, serializer: ::V0::BookSerializer::Model) { object }
    end
  end
end
