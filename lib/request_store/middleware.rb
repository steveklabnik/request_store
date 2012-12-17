module RequestStore
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
