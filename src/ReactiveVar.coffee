
Tracker = require "tracker"
Type = require "Type"
Any = require "Any"

type = Type "ReactiveVar"

type.defineArgs
  value: Any
  keyPath: String

type.defineValues (value, keyPath) ->

  _dep: Tracker.Dependency()

  _value: value

  _keyPath: keyPath

type.defineGetters

  keyPath: -> @_keyPath

type.defineMethods

  compare: (oldValue, newValue) ->
    return oldValue is newValue

  get: ->
    @_dep.depend() if Tracker.isActive
    return @_value

  set: (newValue) ->
    return if @compare @_value, newValue
    @_value = newValue
    @_dep.changed()
    return

  add: (value) ->
    @set @_value + value

  sub: (value) ->
    @set @_value - value

  _numListeners: ->
    count = 0
    count += 1 for id in Object.keys @_dep._dependentsById
    return count

module.exports = type.build()
