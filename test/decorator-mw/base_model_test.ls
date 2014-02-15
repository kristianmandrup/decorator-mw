requires  = require '../../requires'

requires.test 'test_setup'

assert  = require('chai').assert
expect  = require('chai').expect

_       = require 'prelude-ls'

Class   = require('jsclass/src/core').Class

Person = requires.clazz 'person'

# load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

BaseModel = requires.lib 'base_model'

describe 'BaseModel' ->
  models = {}

  specify 'is a Class' ->
    expect(BaseModel.constructor).to.eql Class

  context 'new empty model' ->
    before ->
      models.empty = new BaseModel

    specify 'is empty' ->
      expect(models.empty).to.be.empty

  context 'person model w name' ->
    var obj

    before ->
      obj := name: 'kris'
      models.kris = new BaseModel obj

    specify 'name is kris' ->
      expect(models.kris.name).to.eql 'kris'
