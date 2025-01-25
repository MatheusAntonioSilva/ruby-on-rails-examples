module ApplicationSerializer
  class Pagination < ActiveModel::Serializer

    attribute(:total_pages) { object.try(:total_pages) }
    attribute(:current_page) { object.try(:current_page) }
    attribute(:next_page) { object.try(:next_page) }
    attribute(:prev_page) { object.try(:prev_page) }
    attribute(:per_page) { object.try(:limit_value) }
    attribute(:total_count) { object.try(:total_count) }
  end
end
