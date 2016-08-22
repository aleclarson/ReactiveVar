
Tracker = require "tracker"
Type = require "Type"
Any = require "Any"

type = Type "ReactiveVar"

type.defineArgs
  value: Any
  compare: Function.withDefault (oldValue, newValue) -> oldValue is newValue

type.defineValues (value, compare) ->

  _dep: Tracker.Dependency()

  _value: value

  _compare: compare

type.defineMethods

  get: ->
    @_dep.depend() if Tracker.isActive
    return @_value

  set: (newValue) ->
    return if @_compare @_value, newValue
    @_value = newValue
    @_dep.changed()
    return

  add: (value) ->
    @set @_value + value

  sub: (value) ->
    @_set @_value - value

  _numListeners: ->
    count = 0
    count += 1 for id in Object.keys @_dep._dependentsById
    return count

module.exports = type.build()
