class RackApp
  attr_reader :last_value

  def call(env)
    RequestStore.store[:foo] ||= 0
    RequestStore.store[:foo] += 1
    @last_value = RequestStore.store[:foo]
    raise 'FAIL' if env[:error]
  end
end
