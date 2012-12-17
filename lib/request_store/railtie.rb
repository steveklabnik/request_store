module RequestStore
  class Railtie < ::Rails::Railtie
    initializer "request_store.insert_middleware" do |app|
      app.config.middleware.use RequestStore::Middleware
    end
  end
end
