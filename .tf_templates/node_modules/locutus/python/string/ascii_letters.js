'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

module.exports = function ascii_letters() {
  // eslint-disable-line camelcase
  //   original by: Yury Shapkarin (http://shapkarin.me)
  //   example 1: ascii_letters()
  //   returns 1: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  var length = 26;
  var i = 65;

  return [].concat(_toConsumableArray(Array(length + 6 + length))).reduce(function (accumulator) {
    return accumulator + String.fromCharCode(i++);
  }, '').match(/[a-zA-Z]+/g).reverse().join('');
};
//# sourceMappingURL=ascii_letters.js.map