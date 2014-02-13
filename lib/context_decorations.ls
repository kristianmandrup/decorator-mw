Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash   = require('jsclass/src/core').Hash

_ = require 'prelude-ls'

requires  = require '../requires'

Decorations = requires.lib 'decorations'

CtxDecorations = new Class(
  initialize: (decorations)->
    @repository = new Hash

    return if decorations is void

    self = @
    if _.is-type 'Object', decorations
      decorations.each (name, dec) ->
        self.set name, dec
    @

  # ctx-name (String) the name of the context, if none given, use 'default' context
  # - get a Hash of decorations for a given context 
  # -----------------------------------------------
  #   override this for more advanced context handling, 
  #   such as when using a context object to determine the decoration to load
  get-ctx: (ctx-name) ->
    ctx-name ||= 'default'
    decs = @ctx-decorations.get(name) || new Decorations
    @ctx-decorations.set name, decs
    decs
 
  # if called only with mode, use default context mode
  get: (ctx, model) ->
    ctx-decorations = if arguments.length is 1 then @get-ctx! else @get-ctx(ctx)  
    ctx-decorations.get model
 
  # if no name set, use decoration name or constructor.display-name
  # various valid ways to call
  #   - set(decoration)
  #   - set('admin', decoration)
  #   - set('admin', 'person', person-decoration)
  set: ->
    switch arguments.length
    case 1
      decoration = arguments.first
      name = @name-of(decoration)
      @get-ctx!.set name, decoration
 
    # todo, allow 2nd argument to be Array of decorations
    case 2
      decoration = arguments.last
      ctx = arguments.first
      name = @name-of(decoration)
      @get-ctx(ctx).set name, decoration
 
    obj = if name? then decorations else decorations[name]
    @repository.set ctx, obj
 
    name-of: (decoration) ->
      unless _.type-of 'Object', decoration
        throw Error "Decorator must be an Object, was: #{decoration}"
      decoration.name!
 
  set-list: ->
    switch arguments.length
    case 1
      decorations = arguments.first
      decorations.each (dec) ->
        @set(dec)
 
    # TODO: clean-up?
    case 2
      ctx = arguments.first
      decorations = arguments.last
      switch typeof decorations
      case 'array'
        decorations.each (dec) ->
          @set(ctx, dec)
      case 'object'
        decorations.each (name, dec) ->
          @set(ctx, name, dec)
 
)

module.exports = CtxDecorations