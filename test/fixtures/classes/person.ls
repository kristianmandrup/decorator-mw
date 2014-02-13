requires  = require '../../../requires'

Class   = require('jsclass/src/core').Class

BaseModel = requires.lib 'base_model'

Person = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)

exports = module.exports = Person