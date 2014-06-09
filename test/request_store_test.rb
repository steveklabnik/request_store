require 'minitest/autorun'

require 'request_store'

class RequestStoreTest < Minitest::Unit::TestCase
  def test_initial_state
    Thread.current[:request_store] = nil
    assert_equal RequestStore.store, Hash.new
  end

  def test_init_with_hash
    RequestStore.clear!
    assert_equal Hash.new, RequestStore.store
  end

  def test_clear
    RequestStore.clear!
    RequestStore.store[:foo] = 1
    RequestStore.clear!
    assert_equal Hash.new, RequestStore.store
  end

  def test_quacks_like_hash
    RequestStore.clear!
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.store[:foo]
    assert_equal 1, RequestStore.store.fetch(:foo)
  end

  def test_read
    RequestStore.clear!
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.read(:foo)
    assert_equal 1, RequestStore[:foo]
  end

  def test_write
    RequestStore.clear!
    RequestStore.write(:foo, 1)
    assert_equal 1, RequestStore.store[:foo]
    RequestStore[:foo] = 2
    assert_equal 2, RequestStore.store[:foo]
  end

  def test_fetch
    RequestStore.clear!
    assert_equal 2, RequestStore.fetch(:foo) { 1 + 1 }
    assert_equal 2, RequestStore.fetch(:foo) { 2 + 2 }
  end

  def test_delegates_to_thread
    RequestStore.clear!
    RequestStore.store[:foo] = 1
    assert_equal 1, Thread.current[:request_store][:foo]
  end
end
