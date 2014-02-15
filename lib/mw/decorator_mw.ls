model-mw      = require 'model-mw'
ModelMw       = model-mw.mw

requires  = require '../../requires'

CtxDecorations = requires.lib 'context_decorations'

module.exports = class DecoratorMw extends ModelMw
  (@context) ->
    super ...
    @decorations = calc-decorations context 
 
  calc-decorations: (context) ->
    if context.decorators? then create-decorations(context.decorators) else app.decorators
 
  create-decorations: (context) ->
    new CtxDecorations context
  
  # lookup context
  # find decoration based on klass and context
  # model will be set by inherited ModelMw 
  # it should detect the clazz attribute of incoming data and 
  # set model (singular) and collection (plural), using inflection
  run: (ctx) ->
    super ...
    klass = @decorations.get @context, @model
    new klass @data