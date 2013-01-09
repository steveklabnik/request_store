# RequestStore [![build status](https://travis-ci.org/steveklabnik/request_store.png?branch=master)](https://travis-ci.org/steveklabnik/request_store) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/steveklabnik/request_store)

Ever needed to use a global variable in Rails? Ugh, that's the worst. If you
need global state, you've probably reached for `Thread.current`. Like this:

```
def self.foo
  Thread.current[:foo] ||= 0
end

def self.foo=(value)
  Thread.current[:foo] = value
end
```

Ugh! I hate it. But you gotta do what you gotta do...

### The problem

Everyone's worrying about concurrency these days. So people are using those
fancy threaded web servers, like Thin or Puma. But if you use `Thread.current`,
and you use one of those servers, watch out! Values can stick around longer
than you'd expect, and this can cause bugs. For example, if we had this in
our controller:

```
def index
  Thread.current[:counter] ||= 0
  Thread.current[:counter] += 1
  
  render :text => Thread.current[:counter]
end
```

If we ran this on MRI with Webrick, you'd get `1` as output, every time. But if
you run it with Thin, you get `1`, then `2`, then `3`...

### The solution

Add this line to your application's Gemfile:

    gem 'request_store'

And change the code to this:

```
def index
  RequestStore.store[:foo] ||= 0
  RequestStore.store[:foo] += 1

  render :text => RequestStore.store[:foo]
end
```

Yep, everywhere you used `Thread.current` just change it to
`RequestStore.store`. Now no matter what server you use, you'll get `1` every
time: the storage is local to that request.

### Rails 2 compatibility

The gem includes a Railtie that will configure everything properly for Rails 3+
apps, but if your app is tied to an older (2.x) version, you will have to
manually add the middleware yourself.  Typically this should just be a matter
of adding:

```
config.middleware.use RequestStore::Middleware
```

into your config/environment.rb.

### No Rails? No Problem!

A Railtie is added that configures the Middleware for you, but if you're not
using Rails, no biggie! Just use the Middleware yourself, however you need.
You'll probably have to shove this somewhere:

```
use RequestStore::Middleware
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Don't forget to run the tests with `rake`.
