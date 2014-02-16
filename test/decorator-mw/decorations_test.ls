requires  = require '../../requires'

requires.test 'test_setup'

assert  = require('chai').assert
expect  = require('chai').expect

_       = require 'prelude-ls'

Person = requires.clazz 'person'

# load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

OrderedHash    = require('jsclass/src/hash').OrderedHash
Decorations    = requires.lib 'decorations'

console.log 'Decorations', Decorations

describe 'Decorations' ->
  decs = {}

  describe 'create instance' ->
    context 'no args' ->
      before ->
        decs.empty = new Decorations

      specify 'has Hash registry' ->
        expect(decs.empty.repository.is-empty!).to.be.true

      specify 'has no keys' ->
        expect(decs.empty.repository.keys!.length).to.equal 0

    context 'with hash' ->
      before ->
        decs.basic = new Decorations 'x': ( -> 'x' ), y: ( -> 'y' )

      specify 'has Hash registry' ->
        decs.basic.repository.should.not.be.empty

      specify 'has 2 keys' ->
        expect(decs.basic.repository.keys!.length).to.equal 2

      specify 'repo x = 1' ->
        expect(decs.basic.find('x')!).to.equal 'x'

      specify 'repo y = 2' ->
        expect(decs.basic.find('y')!).to.equal 'y'

  describe 'find' ->
    context 'empty repo' ->
      before ->
        decs.empty = new Decorations
      specify 'x not found' ->
        expect(decs.empty.find 'x').to.equal null

    context 'repo with xx' ->
      before ->
        decs.basic = new Decorations xx: 'y'
      specify 'not found' ->
        expect(decs.basic.find 'x').to.equal null

    context 'repo with x' ->
      before ->
        decs.basic = new Decorations x: 'y'
      specify 'found' ->
        expect(decs.basic.find 'x').to.equal 'y'

  describe 'register' ->
    context 'with x' ->
      before ->
        decs.setme = new Decorations

      specify 'x is found' ->
        expect( -> decs.setme.register 'x').to.throw


    context 'with x, Function' ->
      before ->
        decs.setme = new Decorations
        decs.setme.register 'x', (-> '2')

      specify 'x is found' ->
        expect(decs.setme.find('x')!).to.equal '2'

      specify 'xx is not found' ->
        expect(decs.setme.find 'xx').to.equal null

    context 'with Hash' ->
      before ->
        decs.setme = new Decorations
        decs.setme.register z: (-> '3')

      specify 'z is found' ->
        expect(decs.setme.find 'z').to.not.equal null

      specify 'z is function' ->
        expect(decs.setme.find('z')!).to.equal '3'

      specify 'zz is not found' ->
        expect(decs.setme.find 'zz').to.equal null

  describe 'decorate' ->
    data-objs = {}

    before ->
      decs.setme = new Decorations
      decs.setme.register z: (-> '3')
      data-objs.empty = {}
      data-objs.wmodel = {
        model: 'z'
      }
      data-objs.wclazz = {
        clazz: 'z'
      }

    context 'with data-obj' ->
      context 'with no model or clazz' ->
        specify 'should throw' ->
          expect( -> decs.setme.decorate data-objs.empty).to.throw

      context 'with model' ->
        specify 'should not throw' ->
          expect(decs.setme.decorate data-objs.wmodel).to.not.throw

      context 'with clazz' ->
        specify 'should not throw' ->
          expect(decs.setme.decorate data-objs.wclazz).to.not.throw

    context 'with data-obj, model' ->
      context 'invalid model' ->
        specify 'should throw' ->
          expect( -> decs.setme.decorate data-objs.empty, 'unknown').to.throw

      context 'valid model' ->
        specify 'should not throw' ->
          expect(decs.setme.decorate data-objs.empty, 'z').to.not.throw

    context 'with Object model: data-obj' ->
      context 'invalid model' ->
        specify 'should throw' ->
          expect( -> decs.setme.decorate unknown: data-objs.empty).to.throw

      context 'valid model' ->
        specify 'should not throw' ->
          expect(decs.setme.decorate z: data-objs.empty).to.not.throw
