require 'mongo'

module NoRelations
  class ChecksController < ::NoRelations::ApplicationController

    def index
      client = Mongo::Client.new('mongodb://mongo/test')
      db = client.database
      collection = client[:people]
      person = collection.find( { name: 'Matheus' } ).first
      'ok' if person.present?
    end
  end
end
