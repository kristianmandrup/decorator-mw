# can be used as clever way to define properties
# https://github.com/azer/property
require 'property'

# https://github.com/melanke/Watch.JS
WatchJS = require "watchjs"
watchArray = require('watch-array')

watch = WatchJS.watch
unwatch = WatchJS.unwatch
callWatchers = WatchJS.callWatchers

ObjDecorator = require '../../obj_decorator'

module.exports = class ClientObjDecorator extends ObjDecorator
  (@model, @context) ->
    super ...

  # used for aggregate property, when any of observed properties are changed
  # this function should be called to recalculate self
  # example: fullName.observes @firstName, @lastName

  # adds all setters to model
  blueprint: (user) ->
    @addSetters!

  settersObj: ->
    res = {}
    setters = Object.keys(@).filter (key) ->
      key.match /^set[A-Z]/
    for setter in setters
      res[setter] = @[setter]
    res

  addSetters: ->
    _.extend @model, @settersObj!

  # create setter for fx fullName
  setter: (name) ->
    self = @
    on: (properties, ...fun) ->
      # create setter on prototype, fx setFullname
      self.prototype['set' + name.capitalize!] = fun
      # setup property to watch specific other properties
      self.prop(name).watches properties

  prop: (name) ->
    self = @
    watches: (properties) ->
      for property in properties
        watch self, name, ->
          # auto call setter when any of watched properties change!
          self['set' + name.capitalize!]()
