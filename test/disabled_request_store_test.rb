# frozen_string_literal: true

require 'minitest/autorun'
require 'request_store'

class DisabledRequestStoreTest < Minitest::Test
  def setup
    RequestStore.end!
    RequestStore.clear!
  end

  def teardown
    RequestStore.end!
    RequestStore.clear!
  end

  def test_read
    RequestStore.write(:foo, :bar)
    assert_nil RequestStore.read(:foo)
    assert_nil RequestStore[:foo]
  end

  def test_write
    assert_equal :bar, RequestStore.write(:foo, :bar)
    assert_equal :bar, RequestStore[:foo] = :bar
  end

  def test_exist?
    RequestStore.write(:foo, :bar)
    assert_equal false, RequestStore.exist?(:foo)
  end
end
