class RackApp
  def call
    RequestStore.store[:foo] ||= 0
    RequestStore.store[:foo] += 1
  end
end
