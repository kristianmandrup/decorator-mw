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

  describe 'set' ->
    context 'repo x' ->
      before ->
        decs.setme = new Decorations

      specify 'x is found' ->
        expect( -> decs.setme.register 'x').to.throw


    context 'repo x = 2' ->
      before ->
        decs.setme = new Decorations
        decs.setme.register 'x', (-> '2')

      specify 'x is found' ->
        expect(decs.setme.find('x')!).to.equal '2'

      specify 'xx is not found' ->
        expect(decs.setme.find 'xx').to.equal null

    context 'repo z = 3' ->
      before ->
        decs.setme = new Decorations
        decs.setme.register z: (-> '3')

      specify 'z is found' ->
        expect(decs.setme.find 'z').to.not.equal null

      specify 'z is function' ->
        expect(decs.setme.find('z')!).to.equal '3'

      specify 'zz is not found' ->
        expect(decs.setme.find 'zz').to.equal null
