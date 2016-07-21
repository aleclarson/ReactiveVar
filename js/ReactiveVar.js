var Any, Tracker, Type, fromArgs, type;

fromArgs = require("fromArgs");

Tracker = require("tracker");

Type = require("Type");

Any = require("Any");

type = Type("ReactiveVar");

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
  _value: fromArgs(0),
  _compare: fromArgs(1)
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

//# sourceMappingURL=map/ReactiveVar.map
