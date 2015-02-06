module RequestStore
  class Railtie < ::Rails::Railtie
    initializer "request_store.insert_middleware" do |app|
      if ActionDispatch.const_defined? :RequestId
        app.config.middleware.insert_after ActionDispatch::RequestId, RequestStore::Middleware
      else
        app.config.middleware.insert_after Rack::MethodOverride, RequestStore::Middleware
      end

      if ActionDispatch.const_defined?(:Reloader) && ActionDispatch::Reloader.respond_to?(:to_cleanup)
        ActionDispatch::Reloader.to_cleanup do
          RequestStore.clear!
        end
      end
    end
  end
end
