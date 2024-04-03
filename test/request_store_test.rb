require 'minitest/autorun'

require_relative '../lib/request_store'

class RequestStoreTest < Minitest::Test
  def setup
    RequestStore.clear!
  end

  def teardown
    RequestStore.clear!
  end

  def test_initial_state
    Thread.current[:request_store] = nil
    assert_equal RequestStore.store, Hash.new
  end

  def test_init_with_hash
    assert_equal Hash.new, RequestStore.store
  end

  def test_assign_store
    store_obj = { test_key: 'test' }
    RequestStore.store = store_obj
    assert_equal 'test', RequestStore.store[:test_key]
    assert_equal store_obj, RequestStore.store
  end

  def test_clear
    RequestStore.store[:foo] = 1
    RequestStore.clear!
    assert_equal Hash.new, RequestStore.store
  end

  def test_quacks_like_hash
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.store[:foo]
    assert_equal 1, RequestStore.store.fetch(:foo)
  end

  def test_read
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.read(:foo)
    assert_equal 1, RequestStore[:foo]
  end

  def test_write
    RequestStore.write(:foo, 1)
    assert_equal 1, RequestStore.store[:foo]
    RequestStore[:foo] = 2
    assert_equal 2, RequestStore.store[:foo]
  end

  def test_fetch
    assert_equal 2, RequestStore.fetch(:foo) { 1 + 1 }
    assert_equal 2, RequestStore.fetch(:foo) { 2 + 2 }
  end

  def test_delete
    assert_equal 2, RequestStore.fetch(:foo) { 1 + 1 }
    assert_equal 2, RequestStore.delete(:foo) { 2 + 2 }
    assert_equal 4, RequestStore.delete(:foo) { 2 + 2 }
  end

  def test_delegates_to_scope
    RequestStore.store[:foo] = 1
    assert_equal 1, RequestStore.scope[:request_store][:foo]
  end

  def test_active_state
    assert_equal false, RequestStore.active?

    RequestStore.begin!
    assert_equal true, RequestStore.active?

    RequestStore.end!
    assert_equal false, RequestStore.active?
  end

  def test_concurrent_scopes
    thread1_scope_id = nil
    thread2_scope_id = nil
    thread1 = Thread.new { thread1_scope_id = RequestStore.scope.object_id }
    thread2 = Thread.new { thread2_scope_id = RequestStore.scope.object_id }
    thread1.join
    thread2.join

    assert thread1_scope_id != thread2_scope_id,
           'concurrent scopes should be different'
  end
end
