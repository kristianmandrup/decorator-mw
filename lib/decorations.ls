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

  # model-name (String) the name of the model
  # returns a "Class"
  find: (model-name) ->
    @repository.get model-name
 
  # model-name: the name of the model
  # klass : the "Class" to set for the model-name key
  # sets a "Class" for the key model-name
  register: (model-name, klass) ->
    unless _.is-type 'Function', klass
      throw Error "klass to be set must be a Function, was: #{typeof klass} :: #{klass}"

    @repository.store model-name, klass
)

module.exports = Decorations