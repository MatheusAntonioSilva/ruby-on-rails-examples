module ApplicationSerializer
  class ListResource < ActiveModel::Serializer

    type 'collection'

    def pagination
      ::ApplicationSerializer::Pagination.new(object)
    end
  end
end
