module Relations
  class ChecksController < ::Relations::ApplicationController

    def index
      'ok' if sqllite_up?
    end

    def writing
      Product.create!(description: "New product #{Product.count + 1}")
      'ok'
    end

    def reading
      Product.all.to_json
    end

    def control_transaction
      Product.transaction do
        begin
          Product.create!(description: "New product #{Product.count + 1}")
          raise StandardError if DataManipulation.to_bool(params[:force_error])

        rescue StandardError
          raise ::ActiveRecord::Rollback
        end
      end

      list
    end

    private

    def sqllite_up?
      Product.count
    end
  end
end
