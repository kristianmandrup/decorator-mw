Class   = require('jsclass/src/core').Class

_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

requires    = require '../requires'
Decorations = requires.lib 'decorations'
Repo      = requires.lib  'repo'

CtxDecorations = new Class(Repo,
  initialize: (decorations) ->
    @call-super!

  # ctx-name (String) the name of the context, if none given, use 'default' context
  # - get a Hash of decorations for a given context 
  # -----------------------------------------------
  #   override this for more advanced context handling, 
  #   such as when using a context object to determine the decoration to load
  get-repo: (ctx-name) ->
    ctx-name ||= 'default'
    decorations = @repository.get(ctx-name) || new Decorations
    @repository.store ctx-name, decorations
    decorations
 
  # if called only with mode, use default context mode
  find: (ctx-name, model) ->
    if model is void
      model = ctx-name
      ctx-name = 'default'

    repo = @get-repo(ctx-name)
    repo.find model
 
  # if no name set, use decoration name or constructor.display-name
  # various valid ways to call
  #   - register decoration
  #   - register 'admin', decoration
  #   - register 'admin', 'person', person-decoration
  register: ->
    console.log 'register: arguments', arguments
    switch arguments.length
    case 1
      decoration = arguments[0]
      name = @name-of(decoration)
      @get-repo!.register name, decoration
 
    # todo, allow 2nd argument to be Array of decorations
    case 2
      decoration = arguments[1]
      ctx = arguments[0]
      name = @name-of(decoration)
      @get-repo(ctx).register name, decoration
 
    obj = if name? then decorations else decorations[name]
    @repository.register ctx, obj
 
  name-of: (decoration) ->
    unless _.is-type 'Object', decoration
      throw Error "Decorator must be an Object, was: #{decoration}"
    decoration.name!
 
  register-list: ->
    self = @
    switch arguments.length
    case 1
      decorations = arguments.first
      decorations.each (dec) ->
        self.register(dec)
 
    # TODO: clean-up?
    case 2
      ctx = arguments.first
      decorations = arguments.last
      switch typeof decorations
      case 'array'
        decorations.each (dec) ->
          self.register(ctx, dec)
      case 'object'
        decorations.each (name, dec) ->
          self.register(ctx, name, dec)
 
)

module.exports = CtxDecorations