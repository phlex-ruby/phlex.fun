# Caching

Phlex uses an in-memory FIFO store to cache sets of HTML attributes to improve performance. This cache is limited to the bytesize of the Ruby files that define each of your Phlex components.

Basing the cache constraint on this means it grows and shrinks with your app, while always being constrained to a reasonable size. There is currently no way to configure this cache. It’s on by default and defaults to a reasonable size.

## Fragment caching

You can cache fragments of your component templates using the `cache` method. This method takes a set of cache keys and a block.

```ruby
def view_template
  cache(@user, @article) do
    h1 { @article.title }
  end
end
```

The block will be yielded only when there is a cache miss. Otherwise, it will render the cached fragment from last time. All positional arguments will be treated as cache keys.

You can also pass keyword arguments, which will be delegated to the `fetch` method on the configured cache store. It’s up to the cache store which options it supports.

```ruby
cache(@article, expires_in: 12.hours) do
  h1 { @article.title }
end
```

Phlex will supplement your cache keys with a few of its own:

1. The time in milliseconds that the app was booted and Phlex was loaded. This invalidates the cache on each deploy in case a template has changed.
2. The name of the current class. This prevents collisions between classes.
3. The name of the current method. This prevents collisions between different methods in the same component class.
4. The line number where the cache method is called. This prevents collisions between different lines, especially when no custom cache keys are provided.

## Low-level fragment caching

`low_level_cache` is the same as `cache` except you control the entire cache key. Phlex will not supplement its own keys so it’s up to you to make sure your cache will be invalidated correctly. This method takes only one cache key, but you can pass an Array. This allows you maximum control.

```ruby
low_level_cache([@article], expires_in: 12.hours) do
  h1 { @article.title }
end
```

## The cache store interface

Cache stores must respond to `fetch(key, &block)` and must return either the result of yielding the block or a previously stored result of yielding the block.

They may also take options as keyword arguments to `fetch`. Keyword arguments passed to `cache` or `low_level_cache` will be delegated to the `fetch` call.

## Configuring a cache store

To configure a cache store, you just need to define the `cache_store` method to return an object implementing the cache store interface. Phlex provides a cache store called `Phlex::FIFOCacheStore`. You can use it like this:

```ruby
class Components::Base
  CACHE = Phlex::FIFOCacheStore.new(
    max_bytesize: 20_000_000 # 20MB
  )

  def cache_store
    CACHE
  end
end
```

It’s important to store the FIFOCacheStore in a constant. If we had initialized it from inside the `cache_store` method, we would get a new store each time that method is called and we’d never have a cache hit.

### Using the Rails cache <Badge type="danger" text="Rails" />

Since Phlex’ cache store interface is a subset of Rails’ cache store interface, any Rails cache store should be a valid Phlex cache store.

```ruby
class Components::Base
  def cache_store
    Rails.cache
  end
end
```

## Supported keys

It’s up to the cache store which keys they support. The `Phlex::FIFOCacheStore` supports the following:

1. `String`, `Symbol`, `Integer`, `Float`, `Time`, `true`, `false`, `nil`
2. Objects that respond to `cache_key`
3. `Array` and `Hash` collections of the above

Since Rails also uses the `cache_key` interface, it should be possible to cache things like ActiveRecord models using the `Phlex::FIFOCacheStore`. However, if you’re using Rails, you should probably just configure your Rails cache store.
