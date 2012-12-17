require "request_store/version"

module RequestStore
  @store = {}

  def self.store
    @store
  end
end
