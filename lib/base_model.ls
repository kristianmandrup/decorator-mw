Class   = require('jsclass/src/core').Class

module.exports = new Class(
  # set my own attributes based on incoming object/hash
  initialize: (obj) ->
    _.keys(obj).each (key) ->
      @[key] = obj[key]
)