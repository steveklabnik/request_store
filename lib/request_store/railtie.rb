module RequestStore
  class Railtie < ::Rails::Railtie
    initializer "request_store.insert_middleware" do |app|
      app.config.middleware.insert_after Rack::MethodOverride, RequestStore::Middleware
    end
  end
end
