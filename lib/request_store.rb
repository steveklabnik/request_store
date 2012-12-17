require "request_store/version"

require "request_store/railtie" if defined?(Rails)

module RequestStore
  def self.store
    Thread.current[:request_store]
  end

  class Middleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      Thread.current[:request_store] = {}
      @app.call(env)
    end
  end
end
