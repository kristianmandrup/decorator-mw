module.exports.Decoration =
  decorators: {}
  decorate: (obj, model, context) ->
    decorator = @decorators[model](context)
    decoratedObj = _.extend {}, obj, decorator.blueprint
    customized = decorator.customizeFor context
    _.extend decoratedObj, customized

  add: (objDecorator) ->
    @decorators[objDecorator.model] = objDecorator
