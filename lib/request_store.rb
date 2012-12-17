require "request_store/version"

module RequestStore
  def self.store
    Thread.current[:request_store] ||= {}
    Thread.current[:request_store]
  end
end
