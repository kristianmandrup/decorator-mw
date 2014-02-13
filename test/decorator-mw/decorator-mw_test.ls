rek       = require 'rekuire'
requires  = rek 'requires'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

Person = requires.clazz 'person'

DecoratorMw = requires.file 'decorator_mw'

load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

ContextDecorators = require('decorator-mw').ContextDecorators

person =
  name: 'Joe 6 Pack'
  age: 28
  clazz: 'person' # important!

# find and instantiate model class via clazz attribute (= 'person')
decorated-person = load-mw-stack.run person

var app

describe DecoratorMw ->
  mws = {}

  describe 'create' ->
    context 'no decorators defined' ->
      specify 'error - missing decorator registry' ->
        expect( -> new DecoratorMw).to.throw

    context 'app.decorators defined' ->
      before ->
        app :=
          decorators: new ContextDecorators

        # should be a global repo
        app.decorators.set 'person', Person

      specify 'no error' ->
        expect( -> new DecoratorMw).to.not.throw

  describe 'create-decorations' ->
    before ->
      app :=
        decorators: new ContextDecorators

    context 'invalid decorations arg' ->
      specify 'fails' ->
        new DecoratorMw.create-decorations []

    context 'valid decorations arg' ->
      specify 'creates it' ->
        new DecoratorMw.create-decorations {}

  describe 'run' ->
    before ->
      app :=
        decorators: new ContextDecorators

      mws.dec = new DecoratorMw

    context 'no context' ->
      specify 'fails' ->
        expect( -> mws.dec.run!).to.throw

    context 'empty context' ->
      specify 'ok' ->
        expect( -> mws.dec.run!).to.not.throw
