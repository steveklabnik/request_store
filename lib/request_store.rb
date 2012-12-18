require "request_store/version"
require "request_store/middleware"
require "request_store/railtie" if defined?(Rails)

module RequestStore
  def self.store
    Thread.current[:request_store]
  end

  def self.clear!
    Thread.current[:request_store] = {}
  end
end
