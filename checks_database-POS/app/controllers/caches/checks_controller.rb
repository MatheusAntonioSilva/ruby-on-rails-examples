require 'redis'

module Caches
  class ChecksController < ::Caches::ApplicationController

    def index
      redis = Redis.new(host: 'redis')
      redis.set("a", 'ok')
      redis.get("a")
    end

    private

    def redis_up?
    end
  end
end
