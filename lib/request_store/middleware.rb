module RequestStore
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      RequestStore.begin!
      @app.call(env)
    ensure
      RequestStore.end!
      RequestStore.clear!
    end
  end
end
