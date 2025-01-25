module ApplicationManager
  class Updater < ApplicationManager::Base

    attr_reader :id, :args

    def initialize(id, args)
      @id = id
      @args = args
    end

    def update(with_transaction = true)
      if with_transaction
        ActiveRecord::Base.transaction { execute_updater }
      else
        execute_updater
      end
    end

    private

    def execute_updater
      raise NotImplementedError
    end
  end
end
