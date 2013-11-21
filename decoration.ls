_ = require "lodash"

module.exports = class Decoration
  # class properties
  @decorators = {}

  @add = (objDecorator, name) ->
    name ||= objDecorator.name
    @decorators[name] = objDecorator

  (@object, @name) ->

  decorateFor: (context) ->
    decorator = @decorators[@name](context)
    decoratedObj = _.extend {}, @object, decorator.blueprint
    customized = decorator.customizeFor context
    _.extend decoratedObj, customized

