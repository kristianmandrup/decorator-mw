# Decorator Mw

Middleware to serialize object to server and back to client

Much TODO...

## Decorator

Using `klass` attribute to lookup class on client class Repo (Hash).

Instantiate Class with object

```LiveScript
Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Forwardable = require('jsclass/src/forward').Forwardable;

BaseModel = new Class(
  initialize: (obj) ->
    _.keys(obj).each (key) ->
      @[key] = obj[key]
)

Person = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)

Decorations = new Class(
  initialize: ->
    @repository = new Hash

  get: (name) ->
    @repository.get name

  set: (name, klass) ->
    @repository.set name, klass
)

ContextDecorations = new Class(
  initialize: ->
    @repository = new Hash

  get-for: (name) ->
    decs = @ctx-decorations.get(name) || new Decorations
    @ctx-decorations.set name, decs
    decs

  get: (ctx, model) ->
    @get(ctx).get model

  set: (ctx, decorations, name) ->
    obj = if name? then decorations else decorations[name]
    @repository.set ctx, obj
)

class DecoratorMw extends ModelMw
  (@context) ->
    @decorations = new ContextDecorations @context

  # lookup context
  # find decoration based on klass and context
  run: (ctx) ->
    super ...
    klass = @decorations.get @context, @model
    new klass @data
```
