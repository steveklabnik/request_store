require 'minitest/test'
require 'minitest/autorun'

require 'request_store'

class MiddlewareTest < Minitest::Test
  def setup
    @app = RackApp.new
    @middleware = RequestStore::Middleware.new(@app)
  end

  def test_middleware_resets_store
    2.times { @middleware.call({}) }

    assert_equal 1, @app.last_value
    assert_equal({}, RequestStore.store)
  end

  def test_middleware_resets_store_on_error
    e = assert_raises RuntimeError do
      @middleware.call({:error => true})
    end

    assert_equal 'FAIL', e.message
    assert_equal({}, RequestStore.store)
  end

  def test_middleware_begins_store
    @middleware.call({})
    assert_equal true, @app.store_active
  end

  def test_middleware_ends_store
    @middleware.call({})
    assert_equal false, RequestStore.active?
  end

  def test_middleware_ends_store_on_error
    assert_raises RuntimeError do
      @middleware.call({:error => true})
    end

    assert_equal false, RequestStore.active?
  end
end
