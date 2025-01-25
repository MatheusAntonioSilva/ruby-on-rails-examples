module ApplicationManager
  class Lister < ApplicationManager::Base

    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 20

    attr_reader :page, :per_page, :filters

    def initialize(page, per_page, filters = {})
      @page = page
      @per_page = per_page
      @filters = filters
    end

    def build
      filter.page(@page).per(@per_page)
    end

    private

    def filter
      raise NotImplementedError
    end

    def page=(page)
      @page = page.to_i
      @page = DEFAULT_PAGE if @page.zero?
    end

    def per_page=(per_page)
      @per_page = per_page.to_i
      @per_page = self.class::DEFAULT_PER_PAGE if @per_page.zero?
    end
  end
end
