var Any, Tracker, Type, type;

Tracker = require("tracker");

Type = require("Type");

Any = require("Any");

type = Type("ReactiveVar");

type.didBuild(function(type) {
  var Property;
  Property = require("Property");
  return Property.inject.ReactiveVar(type);
});

type.argumentTypes = {
  value: Any,
  compare: Function
};

type.argumentDefaults = {
  compare: function(oldValue, newValue) {
    return oldValue === newValue;
  }
};

type.defineValues({
  _dep: function() {
    return Tracker.Dependency();
  },
  _value: function(value) {
    return value;
  },
  _compare: function(value, compare) {
    return compare;
  }
});

type.defineMethods({
  get: function() {
    if (Tracker.isActive) {
      this._dep.depend();
    }
    return this._value;
  },
  set: function(newValue) {
    if (this._compare(this._value, newValue)) {
      return;
    }
    this._value = newValue;
    this._dep.changed();
  },
  _numListeners: function() {
    var count, i, id, len, ref;
    count = 0;
    ref = Object.keys(this._dep._dependentsById);
    for (i = 0, len = ref.length; i < len; i++) {
      id = ref[i];
      count += 1;
    }
    return count;
  }
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/ReactiveVar.map