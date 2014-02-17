Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/hash').Hash

_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

requires  = require '../requires'

Repo      = requires.lib  'repo'
Debugger  = requires.file 'debugger'

Decorations = new Class(Repo,
  initialize: (hash) ->
    @call-super!

  is-empty: ->
    @repository.is-empty!

  # model-name (String) the name of the model
  # returns a "Class"
  find: (model-name) ->
    @repository.get model-name
 
  # model-name: the name of the model
  # klass : the "Class" to set for the model-name key
  # sets a "Class" for the key model-name
  register: ->
    self = @
    switch arguments.length
    case 1
      hash = arguments[0]

      unless typeof hash is 'object'
        throw Error "Invalid argument, must be an Object, was: #{hash}"

      _.keys(hash).each (key) ->
        self.register key, hash[key]
    case 2
      model-name  = arguments[0]
      klass       = arguments[1]

      unless _.is-type 'String', model-name
        throw Error "Repository key must be a String, was: #{typeof model-name}, #{model-name}"

      unless _.is-type 'Function', klass
        throw Error "klass to be set for #{model-name} must be a Function, was: #{typeof klass} , #{klass}"

      @repository.store model-name, klass
    default
      throw Error "Invalid arguments, must take Hash or String, Function, was: #{arguments}"

  decorate: (data-obj, model) ->
    # TODO: improve this? allow model function instead?
    model ||= data-obj.model || data-obj.clazz
    unless model
      if arguments.length is 1
        return @decorate-w-hash data-obj

      throw Error "Unable to determine model to be used for applying decoration"

    decorator = @repository.get model
    unless decorator
      throw Error "No decorator for #{model} could be found in the repo: #{@repository}"

    @apply-decoration data-obj, decorator

  decorate-w-hash: (hash) ->
    self = @
    keys = _.keys(hash)
    if keys.length is 1
      decorated = null
      _.keys(hash).each (key) ->
        decorated = self.decorate hash[key], key
      return decorated

    throw Error "Decoration error, invalid argument: #{hash}"

  # TODO: refactor and clean up (extract classes?)
  apply-decoration: (data-obj, decorator) ->
    if typeof decorator is 'object'
      @apply-decoration-blueprint data-obj, decorator

    if typeof decorator is 'function'
      # constructor function (or class)
      return new decorator data-obj

    throw Error "Can't determine a way to apply the decorator: #{decorator} on the data object"

  apply-decoration-blueprint: (data-obj, decorator) ->
    # blueprint mode
    if decorator['set-data']
      decorator.set-data data-obj
      decorator
)

module.exports = Decorations