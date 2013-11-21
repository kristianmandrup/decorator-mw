_ = require "lodash"

module.exports.ObjDecorator = class ObjDecorator
  (@model, @context) ->

  blueprint: {}

  customizeFor: (@context) ->

  decorate: ->
    @model