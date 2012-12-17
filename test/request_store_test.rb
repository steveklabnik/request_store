require 'minitest/autorun'

require 'request_store'

class RequestStoreTest < Minitest::Unit::TestCase
  def test_init_with_hash
    RequestStore.init_or_clear
    assert_equal Hash.new, RequestStore.store
  end

  def test_clear
    RequestStore.init_or_clear
    RequestStore.store[:foo] = 1
    RequestStore.init_or_clear
    assert_equal Hash.new, RequestStore.store
  end

  def test_quacks_like_hash
    Thread.current[:request_store] = {}
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.store[:foo]
    assert_equal 1, RequestStore.store.fetch(:foo)
  end

  def test_delegates_to_thread
    Thread.current[:request_store] = {}
    RequestStore.store[:foo] = 1
    assert_equal 1, Thread.current[:request_store][:foo]
  end
end
