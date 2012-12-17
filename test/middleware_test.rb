require 'minitest/autorun'

require 'request_store'

class MiddlewareTest < Minitest::Unit::TestCase
  def test_middleware_resets_store
    app = RackApp.new
    middleware = RequestStore::Middleware.new(app)

    middleware.call({})
    middleware.call({})

    assert_equal 1, Thread.current[:request_store][:foo]
  end
end
