module BookManager
  class Lister < ApplicationManager::Lister

    attr_reader :joins

    def initialize(page, per_page, filters = {})
      super(page, per_page, filters)
      @joins = []
    end

    private

    def filter
      search.ransack(distinct: true).result
    end

    def conditions
      return if filters.blank?
      return @conditions if @conditions.present?

      conditions_treated = []
      conditions_treated << "books.title = '#{filters[:title]}'" if filters[:title].present?
      conditions_treated << "books.description LIKE '%#{filters[:description]}%'" if filters[:description].present?

      if filters[:author].present?
        @joins << [:author]
        conditions_treated << "authors.name = '#{filters[:author]}'"
      end

      @conditions = conditions_treated.join(' AND ').strip
    end

    def search
      if conditions.present?
        search = Book.joins(:author).where(conditions)
      else
        search = Book
      end
    end
  end
end
