'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

module.exports = function ascii_lowercase() {
  // eslint-disable-line camelcase
  //   original by: Yury Shapkarin (http://shapkarin.me)
  //   example 1: ascii_lowercase()
  //   returns 1: 'abcdefghijklmnopqrstuvwxyz'

  var length = 26;
  var i = 65 + length + 6;

  return [].concat(_toConsumableArray(Array(length))).reduce(function (accumulator) {
    return accumulator + String.fromCharCode(i++);
  }, '');
};
//# sourceMappingURL=ascii_lowercase.js.map