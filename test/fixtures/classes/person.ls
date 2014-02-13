rek       = require 'rekuire'
requires  = rek 'requires'

Class   = require('jsclass/src/core').Class

BaseModel = requires.file 'base_model'

module.exports = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)
