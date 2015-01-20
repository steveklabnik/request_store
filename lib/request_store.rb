require "request_store/version"
require "request_store/middleware"
require "request_store/railtie" if defined?(Rails::Railtie)

module RequestStore
  extend self
  extend Forwardable

  def_delegators :store, :[], :[]=, :delete, :key?

  alias_method :read, :[]
  alias_method :write, :[]=
  alias_method :exist?, :key?

  def store
    Thread.current[:request_store] ||= {}
  end

  def clear!
    Thread.current[:request_store] = {}
  end

  def fetch(key, &block)
    store[key] = yield unless exist?(key)
    store[key]
  end
end
