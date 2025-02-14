# Caching

The most expensive (performance-wise) process in Phlex is building attributes, where we turn a Ruby Hash into an String of valid HTML attributes.

Phlex supports all kinds of attributes including deeply-nested hashes, arrays, sets, strings, symbols, boolean values and even custom objects. It even has special handling for `class` and `style` attributes.

Attributes need to be calculated thousands of times per render. One advantage we have is attributes are always calculated the same way. The same hash will always produce the same string of HTML.

This problem lends itself well to caching. If we store the result of the first calculation, we can then reuse it the next time we get the same set of attributes.

## Keying the cache

In order for the cache to work, we need to be able to look at a set of attributes and quickly determine if we’ve already calculated the HTML string for it. Ruby makes this pretty easy since Ruby hashes can be used as keys in other Hashes.

We can do something like this:

```ruby
CACHE[attributes_hash] ||= calculate_attributes(attributes_hash)
```

This works pretty well, but there’s actually a faster way. Ruby’s `Hash` objects have a `#hash` method that returns an `Integer` that is a digest of the contents of the hash. The same contents will always produce the same integer.

We can use this integer as the key in our cache which makes lookups much faster.

```ruby
CACHE[attributes_hash.hash] ||= calculate_attributes(attributes_hash)
```

There’s a catch though. The `#hash` method is not guaranteed to be unique. While it’s very, very unlikely, it is possible for two different hashes to produce the same integer. This is called a hash collision.

What we can do to avoid this is to store both the original attributes hash and the calculated HTML string in the cache keyed by this hash integer. Then, if we get a hit, we can compare the original attributes hash to the one we’re looking for to make sure they’re exactly the same.

```ruby
key = attributes_hash.hash
cached = CACHE[key]

if cached && cached[0] == attributes_hash
  cached[1]
else
  CACHE[key] = [attributes_hash, calculate_attributes(attributes_hash)]
end
```

It’s a bit convoluted but it works and it’s faster than using the Hash object as the key, while still being correct.

## Key eviction

So far we’ve been using a Hash for our cache store, but this has some problems. If you have any dynamic content in your attributes, a cache like this will grow indefinitely.

It’s actually pretty common, for example, to render something like JSON into a data attribute on a custom element. These attributes can be very large and they’re often unique for each render so there’s little benefit in caching them.

We need a way to set a limit on the size of the cache and start evicting keys when we reach the limit.

There are a few different approaches to key eviction:

- **Least Recently Used (LRU)** — with this approach, the first keys to be evicted are the ones that were least recently accessed or added to the cache.
- **Last In First Out (LIFO)** — with this approach, the first keys to be evicted are the ones that were added to the cache last.
- **First In First Out (FIFO)** — with this approach, the first keys to be evicted are the ones that were added to the cache first.

Naively, the LRU approach seems like the best one. It’s the most fair and it’s the one that’s most likely to keep the most useful keys in the cache. However the bookkeeping overhead to know which keys have been accessed most recently, also makes it slower to access.

If you think about it, with an LRU cache, you need to keep track of the order in which keys were accessed. That means every read also requires a write, which is more expensive. In order to avoid contention, you would also need to use a `Mutex` to make sure only one thread is accessing the cache at a time.

In contrast, LIFO and FIFO caches are much simpler, especially as Ruby’s `Hash` class maintains insertion order.

Phlex uses a FIFO cache. When the cache reaches a certain size, it will evict the oldest keys first. This is a simple and fast approach that works well for our use case.

## Sizing

Since attributes come in all different shapes and sizes, Phlex’ FIFO cache keeps track of how many bytes are stored in the cache. When the cache reaches its maximum size, the next write will evict the oldest keys until there is enough space for the new key.

We also set a maximum size for a single key. Larger attributes are more likely to be unique (e.g. JSON data) and caching them is less helpful.

But how do we determine the size of the cache itself? Ideally, it would be just large enough to hold all the static, reused attributes but not waste any space on dynamic attributes that will probably only be used just once.

This is a very tricky problem and one that we haven’t entirely solved, however we do have an approach that works pretty well.

We use the total file size of all of your components as an upper bound for the cache size. This is probably a bit much — it’s very unlikely the entire file was made up of attributes. But remember we’re talking kilobytes here. It’s a pretty good approximation that has a fixed limit and expands predictably with your app.

## Avoiding race conditions

The Phlex attribute cache is global, which allows for maximum reuse of calculated attributes. However, this also means that it’s shared between all threads in your application.

Inside the FIFO cache, we use a `Mutex` to make sure only one thread is writing to the cache or modifying its size at a time.

Because we can expire keys we also need to be careful to not do something like this:

```ruby
if CACHE[key]
  do_something_with(CACHE[key])
end
```
