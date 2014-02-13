Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/hash').Hash

_       = require 'prelude-ls'
require 'sugar'

requires  = require '../requires'

Debugger  = require '../debugger'

Decorations = new Class(
  include: Debugger

  initialize: (decorations) ->
    self = @
    @repository = {}

    return if decorations is void

    unless _.is-type 'Object', decorations
      throw Error "Must be an Object, was : #{typeof klass} #{decorations}"

    _.keys(decorations).each (name) ->
      self.repository[name] = decorations[name]
    @

  # model-name (String) the name of the model
  # returns a "Class"
  get: (model-name) ->
    @repository[model-name]
 
  # model-name: the name of the model
  # klass : the "Class" to set for the model-name key
  # sets a "Class" for the key model-name
  set: (model-name, klass) ->
    unless _.is-type 'Function', klass
      throw Error "klass to be set must be a Function, was: #{typeof klass} :: #{klass}"

    @repository[model-name] = klass
)

module.exports = Decorations