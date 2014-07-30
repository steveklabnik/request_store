module RequestStore
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    ensure
      RequestStore.clear!
    end
  end
end
