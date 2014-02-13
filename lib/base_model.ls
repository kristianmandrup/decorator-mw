Class   = require('jsclass/src/core').Class

_       = require 'prelude-ls'

Base = new Class(
  initialize: (obj) ->
    return if obj is void
    unless _.is-type 'Object', obj
      throw Error "Must be an Object, was: #{obj}"
    self = @
    _.keys(obj).each (key) ->
      self[key] = obj[key]
    @
)

module.exports = Base