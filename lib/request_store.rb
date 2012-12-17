require "request_store/version"

module RequestStore
  def self.store
    Thread.current[:request_store] ||= {}
    Thread.current[:request_store]
  end

  class Middleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      Thread.current[:request_store] = {}
      @app.call
    end
  end
end
