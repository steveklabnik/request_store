# frozen_string_literal: true

require 'minitest/autorun'
require 'request_store'

class RequestStoreTest < Minitest::Test
  def setup
    RequestStore.begin!
    RequestStore.clear!
  end

  def teardown
    RequestStore.end!
    RequestStore.clear!
  end

  def test_initial_state
    Thread.current[:request_store] = nil
    assert_equal RequestStore.store, Hash.new
  end

  def test_init_with_hash
    assert_equal Hash.new, RequestStore.store
  end

  def test_store
    RequestStore.end!
    RequestStore.store[:foo] = :bar
    assert_equal Hash.new, RequestStore.store

    RequestStore.begin!
    RequestStore.store[:foo] = :bar
    assert_equal Hash(foo: :bar), RequestStore.store
  end

  def test_store=
    assert_raises(ArgumentError) { RequestStore.store = nil }

    RequestStore.store = { foo: :bar }
    assert_equal :bar, RequestStore.store[:foo]
    assert_equal Hash(foo: :bar), RequestStore.store
  end

  def test_clear!
    RequestStore.store = { foo: :bar }
    RequestStore.clear!
    assert_equal Hash.new, RequestStore.store
  end

  def test_begin!
    RequestStore.begin!
    assert_equal true, Thread.current[:request_store_active]
  end

  def test_end!
    RequestStore.end!
    assert_equal false, Thread.current[:request_store_active]
  end

  def test_active?
    RequestStore.begin!
    assert_equal true, RequestStore.active?

    RequestStore.end!
    assert_equal false, RequestStore.active?
  end
end
