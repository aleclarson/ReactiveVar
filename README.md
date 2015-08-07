
# reactive-var v1.0.6 [![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)

This package is stripped from [meteor/reactive-var](https://atmospherejs.com/meteor/reactive-var) and made compatible with [React Native](https://github.com/facebook/react-native).

**Note:** This package is only for client-side usage.

&nbsp;

## usage

```js
var ReactiveVar = require('reactive-var');

// Any value type can be used.
var myVar = ReactiveVar(1);

myVar.get() // => 1

myVar.set(0) // => undefined

myVar.equals(1) // => true
```

Learn more [here](http://docs.meteor.com/#/full/reactivevar_pkg).

&nbsp;

## install

```sh
npm install aleclarson/reactive-var#1.0.6
```
