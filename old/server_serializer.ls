type = require './type'
ObjDecorator = require '../../obj_decorator'

module.exports = class ServerSerializer extends ObjDecorator
  (@model, @context) ->
    super ...

  serialize: ->
    @propertiesOnly!
    @model

  # filters out all function properties so that only data properties are sent to server
  # what about prototype properties, will they be stored in RacerJS?
  propertiesOnly: ->
    Object.keys(@model).filter (key) ->
      type(@[key]) isnt 'function'
