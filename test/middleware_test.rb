require 'minitest/autorun'

require 'request_store'

class MiddlewareTest < Minitest::Unit::TestCase
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
    errors = []
    begin
      @middleware.call({:error => true})
    rescue => e
      errors << e
    end

    assert_equal ['FAIL'], errors.map(&:message)
    assert_equal({}, RequestStore.store)
  end
end
