module RequestStore
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      RequestStore.clear!
      @app.call(env)
    end
  end
end
