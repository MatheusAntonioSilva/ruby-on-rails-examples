module BookManager
  class Shower < ApplicationManager::Shower

    private

    def instance
      ::Book.find(id)
    end
  end
end
