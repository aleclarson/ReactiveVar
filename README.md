
# reactive-var v2.0.0 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

Uses [**aleclarson/tracker**](https://github.com/aleclarson/tracker) under-the-hood for reactivity.

```coffee
ReactiveVar = require "reactive-var"

foo = ReactiveVar 0

foo.get() # => 0

foo.set   # => 2
```

• Each `ReactiveVar` is backed by a `Tracker.Dependency`. This makes `foo.get()` reactive.

• You can specify a comparison function by passing a second argument:

```coffee
foo = ReactiveVar 0, (a, b) ->
  # Return true if the values are equal!
```

Otherwise, a strict `===` comparison is used by default.
