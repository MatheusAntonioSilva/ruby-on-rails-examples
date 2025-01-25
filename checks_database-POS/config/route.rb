require 'sinatra/base'
require 'json'

class Route < ::Sinatra::Base
  set :bind, '0.0.0.0'
  set :static, true
  set :public_dir, File.expand_path(__dir__)

  get '/' do
    ::ApplicationController.new(params).hello_word
  end

  get '/checks/relations' do
    ::Relations::ChecksController.new(params).index
  end

  get '/checks/relations/reading' do
    ::Relations::ChecksController.new(params).reading
  end

  get '/checks/relations/writing' do
    ::Relations::ChecksController.new(params).writing
  end

  get '/checks/relations/control_transaction' do
    ::Relations::ChecksController.new(params).control_transaction
  end

  get '/checks/caches' do
    ::Caches::ChecksController.new(params).index
  end

  get '/checks/no_relations' do
    ::NoRelations::ChecksController.new(params).index
  end

  get '/checks/extras/events/producer' do
    ::Extras::Events::ChecksController.new(params).producer
  end

  get '/checks/extras/events/consumer' do
    ::Extras::Events::ChecksController.new(params).consumer
  end
end
