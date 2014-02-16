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
    @repository.get(ctx-name)

  ctx: (name) ->
    @get-or-init-repo name

  get-or-init-repo: (ctx-name) ->
    ctx-name ||= 'default'
    @get-repo(ctx-name) || @init-repo(ctx-name)

  init-repo: (ctx-name) ->
    @repository.store ctx-name, new Decorations
    @repository.get ctx-name

  # if called only with mode, use default context mode
  find: (ctx-name, model) ->
    if model is void
      model = ctx-name
      ctx-name = 'default'

    repo = @get-repo ctx-name
    repo.find model if repo
 
  # if no name set, use decoration name or constructor.display-name
  # various valid ways to call
  #   - register decoration
  #   - register 'admin', decoration
  #   - register 'admin', 'person', person-decoration
  register: ->
    self = @
    switch arguments.length
    case 1
      decoration = arguments[0]
      name = @name-of(decoration)
      @get-or-init-repo!.register name, decoration
 
    # todo, allow 2nd argument to be Array of decorations
    case 2
      decoration = arguments[1]
      ctx = arguments[0]
      repo = @get-or-init-repo ctx

      # only if single Decorations being registered!
      switch typeof decoration
      case 'array'
        register-list ctx, decoration

      case 'object'
        unless decoration.name?
          @register-hash ctx, decoration
          return

        # register single obj
        name = @name-of(decoration)
        repo.register name, decoration

    case 3
      ctx = arguments[0]
      model-name = arguments[1]
      klass = arguments[2]

      repo = @get-or-init-repo ctx
      repo.register model-name, klass

  name-of: (decoration) ->
    unless _.is-type 'Object', decoration
      throw Error "Decorator must be an Object, was: #{decoration}"

    unless decoration.name?
      throw Error "Decorator must have a name function, #{decoration}"
    decoration.name!

  register-hash: (ctx, hash) ->
    self = @
    _.keys(hash).each (key) ->
      self.register ctx, key, hash[key]

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

  # for-model('person').register guest: GuestPerson, admin: AdminPerson,
  for-model: (model-name) ->
    new ModelCtxFactory @, model-name
)

ModelCtxFactory = Class(
  initialize: (@ctx-decorations, @model) ->

  register: (hash) ->
    self = @
    _.keys(hash).each (ctx) ->
      self.register ctx, @model, hash[ctx]
)


module.exports = CtxDecorations