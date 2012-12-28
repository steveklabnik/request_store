require "request_store/version"
require "request_store/middleware"
require "request_store/railtie" if defined?(Rails) && Rails.version.to_i > 2

module RequestStore
  def self.store
    Thread.current[:request_store] ||= {}
  end

  def self.clear!
    Thread.current[:request_store] = {}
  end
end
