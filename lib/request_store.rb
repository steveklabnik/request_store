# frozen_string_literal: true

require "forwardable"
require "request_store/version"
require "request_store/middleware"
require "request_store/railtie" if defined?(Rails::Railtie)

module RequestStore
  class << self
    extend Forwardable

    def_delegators :store, :[], :[]=, :fetch, :delete, :key?, :has_key?

    alias :read :[]
    alias :write :[]=
    alias :exist? :key?

    def store
      return {} unless active?
      Thread.current[:request_store] ||= {}
    end

    def store=(store)
      raise ArgumentError, "Must be a Hash or a subclass of Hash" unless store.is_a?(Hash)
      Thread.current[:request_store] = store
    end

    def clear!
      Thread.current[:request_store] = {}
    end

    def begin!
      Thread.current[:request_store_active] = true
    end

    def end!
      Thread.current[:request_store_active] = false
    end

    def active?
      !!Thread.current[:request_store_active]
    end
  end
end
