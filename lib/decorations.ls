Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash   = require('jsclass/src/core').Hash

module.exports = new Class(
  initialize: ->
    @repository = new Hash
 
  # model-name (String) the name of the model
  # returns a "Class"
  get: (model-name) ->
    @repository.get model-name
 
  # model-name: the name of the model
  # klass : the "Class" to set for the model-name key
  # sets a "Class" for the key model-name
  set: (model-name, klass) ->
    @repository.set model-name, klass
)