# frozen_string_literal: true

require 'minitest/autorun'
require 'request_store'

class ActiveRequestStoreTest < Minitest::Test
  def setup
    RequestStore.begin!
    RequestStore.clear!
  end

  def teardown
    RequestStore.end!
    RequestStore.clear!
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
    assert_equal 4, RequestStore.fetch(:foo) { 2 + 2 }
    assert_equal 6, RequestStore.fetch(:foo, 6)
    assert_equal 8, RequestStore.fetch(:foo, 6) { 4 + 4 }
    assert_raises(KeyError) { RequestStore.fetch(:foo) }
  end

  def test_delete
    assert_equal 4, RequestStore.delete(:foo) { 2 + 2 }
    RequestStore.write(:foo, 1)
    assert_equal 1, RequestStore.delete(:foo) { 2 + 2 }
  end

  def test_delegates_to_thread
    RequestStore.store[:foo] = 1
    assert_equal 1, Thread.current[:request_store][:foo]
  end
end
