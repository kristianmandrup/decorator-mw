requires  = require '../../requires'
requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

middleware = require 'middleware'
Middleware = middleware.Middleware

DecoratorMw = requires.mw 'decorator_mw'

CtxDecorations = requires.lib ('context_decorations')

Person = requires.clazz 'person'

var app

describe 'DecoratorMw' ->
  mws       = {}
  persons   = {}
  decorated = {}

  describe 'create' ->
    context 'no decorators defined' ->
      specify 'allow creationg withour registry' ->
        expect( -> new DecoratorMw).to.not.throw

    context 'app.decorators defined' ->
      before ->
        app :=
          decorators: new CtxDecorations

        # should be a global repo
        app.decorators.register 'person', Person

      specify 'no error' ->
        expect( -> new DecoratorMw).to.not.throw

  describe 'create-decorations' ->
    before ->
      app :=
        decorators: new CtxDecorations

    context 'invalid decorations arg' ->
      specify 'fails' ->
        new DecoratorMw.create-decorations []

    context 'valid decorations arg' ->
      specify 'creates it' ->
        new DecoratorMw.create-decorations {}

  describe 'run' ->
    before ->
      app :=
        decorators: new CtxDecorations

      mws.dec = new DecoratorMw

    context 'no context' ->
      specify 'fails' ->
        expect( -> mws.dec.run!).to.throw

    context 'empty context' ->
      specify 'ok' ->
        expect( -> mws.dec.run!).to.not.throw

  xdescribe 'full mw-stack' ->
    before ->
      console.log 'defining mw-stack'
      load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

      persons.joe :=
        name: 'Joe 6 Pack'
        age: 28
        clazz: 'person' # important!

      # find and instantiate model class via clazz attribute (= 'person')
      decorated.person = load-mw-stack.run person
