class RackApp
  def call(env)
    RequestStore.store[:foo] ||= 0
    RequestStore.store[:foo] += 1
  end
end
