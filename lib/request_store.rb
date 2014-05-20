require "request_store/version"
require "request_store/middleware"
require "request_store/railtie" if defined?(Rails::Railtie)

module RequestStore
  class << self
    def store
      Thread.current[:request_store] ||= {}
    end

    def clear!
      Thread.current[:request_store] = {}
    end

    def read(key)
      store[key]
    end
    alias_method :[], :read

    def write(key, value)
      store[key] = value
    end
    alias_method :[]=, :write

    def exist?(key)
      store.key?(key)
    end

    def fetch(key, &block)
      store[key] = yield unless exist?(key)
      store[key]
    end
  end
end
