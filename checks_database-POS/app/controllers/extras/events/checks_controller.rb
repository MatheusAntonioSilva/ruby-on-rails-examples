
module Extras
  module Events
    class ChecksController < ::Extras::Events::ApplicationController

      def producer
        kafka = ::Kafka.new('kafka:29092')
        kafka.deliver_message({ product_id: Product.first.id }.to_json, topic: 'ruby_kafka')

        'ok'
      end

      def consumer
        kafka = ::Kafka.new('kafka:29092')
        kafka.each_message(topic: 'ruby_kafka') do |message|
          parsed_message = JSON.parse(message.value)
          product = ::Product.find_by(id: parsed_message['product_id'])
          product.update(description: 'Update by Kafka')
          return 'ok'
        end
      end
    end
  end
end
