New version num
-------

- Requirement Ruby 2.0+.
- RequestStore is safe in queue or rake now, because it disabled cache. If you still want to use cache in there places, you must call RequestStore.begin!.
- `RequestStore#fetch` method is consistent with `Hash#fetch` now.
```
# Before
RequestStore.fetch(:foo) { :bar }
RequestStore[:foo] == :bar  # return true
# Now
RequestStore.fetch(:foo) { :bar }
RequestStore.exist?(:foo)  # return false
```
