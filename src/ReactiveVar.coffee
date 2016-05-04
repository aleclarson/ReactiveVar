
{ Any } = require "type-utils"

Tracker = require "tracker"
Type = require "Type"

type = Type "ReactiveVar"

type.didBuild (type) ->
  Property = require "Property"
  Property.inject.ReactiveVar type

type.argumentTypes =
  value: Any
  compare: Function

type.argumentDefaults =
  compare: (oldValue, newValue) ->
    return oldValue is newValue

type.defineValues

  _dep: -> Tracker.Dependency()

  _value: (value) -> value

  _compare: (value, compare) -> compare

type.defineMethods

  get: ->
    @_dep.depend() if Tracker.isActive
    return @_value

  set: (newValue) ->
    return if @_compare @_value, newValue
    @_value = newValue
    @_dep.changed()
    return

  _numListeners: ->
    count = 0
    count += 1 for id in Object.keys @_dep._dependentsById
    return count

module.exports = type.build()
