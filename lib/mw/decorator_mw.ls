model-mw      = require 'model-mw'
ModelMw       = model-mw.mw

requires  = require '../../requires'

CtxDecorations = requires.lib 'context_decorations'

module.exports = class DecoratorMw extends ModelMw
  (@context) ->
    super ...
    @set-decorations context

  set-decorations: (context) ->
    decs = @calc-decorations context
    if typeof decs is 'object'
      if decs.constructor is CtxDecorations
        # console.log 'set decs', decs
        @decorations = decs

  calc-decorations: (context) ->
    if typeof context is 'object'
      unless context.decorators?
        throw Error "app not defined" unless app?
        return app.decorators

      return @create-decorations @context.decorators

  create-decorations: (decorators) ->
    new CtxDecorations decorators
  
  # lookup context
  # find decoration based on klass and context
  # model will be set by inherited ModelMw 
  # it should detect the clazz attribute of incoming data and 
  # set model (singular) and collection (plural), using inflection
  run: (ctx) ->
    super ...
    @set-decorations ctx
    klass = @decorations.get @context, @model
    new klass @data