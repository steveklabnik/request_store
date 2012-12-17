require 'minitest/autorun'

require 'request_store'

class RequestStoreTest < Minitest::Unit::TestCase
  def test_quacks_like_hash
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.store[:foo]
    assert_equal 1, RequestStore.store.fetch(:foo)
  end
end
