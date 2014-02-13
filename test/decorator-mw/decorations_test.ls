rek       = require 'rekuire'
requires  = rek 'requires'

requires.test 'test_setup'

assert  = require('chai').assert
expect  = require('chai').expect

_       = require 'prelude-ls'

Person = requires.clazz 'person'

# load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

Decorations = requires.file 'decorations'

console.log 'Decorations', Decorations

describe 'Decorations' ->
  decs = {}

  describe 'create instance' ->
    context 'no args' ->
      before ->
        decs.empty = new Decorations
        console.log 'empty', decs.empty, decs.empty.repository

      specify 'has Hash registry' ->
        expect(decs.empty.repository).to.be.empty

      specify 'has no keys' ->
        _.keys(decs.empty.repository).length.should.eql 0

    context 'with hash' ->
      before ->
        decs.basic = new Decorations x: ( -> 'x' ), y: ( -> 'y' )

      specify 'has Hash registry' ->
        decs.basic.repository.should.not.be.empty

      specify 'has 2 keys' ->
        _.keys(decs.basic.repository).length.should.eql 2

      specify 'repo x = 1' ->
        decs.basic.repository.x!.should.eql 'x'

      specify 'repo y = 2' ->
        decs.basic.repository.y!.should.eql 'y'

  describe 'get' ->
    context 'empty repo' ->
      before ->
        decs.empty = new Decorations
      specify 'x not found' ->
        expect(decs.empty.get 'x').to.eql void

    context 'repo with xx' ->
      before ->
        decs.basic = new Decorations xx: 'y'
      specify 'not found' ->
        expect(decs.basic.get 'x').to.eql void

    context 'repo with x' ->
      before ->
        decs.basic = new Decorations x: 'y'
      specify 'found' ->
        expect(decs.basic.get 'x').to.eql 'y'

  describe 'set' ->
    context 'repo x' ->
      before ->
        decs.setme = new Decorations

      specify 'x is found' ->
        expect( -> decs.setme.set 'x').to.throw


    context 'repo x = 2' ->
      before ->
        decs.setme = new Decorations
        decs.setme.set 'x', (-> '2')

      specify 'x is found' ->
        expect(decs.setme.get('x')!).to.eql '2'

      specify 'xx is not found' ->
        expect(decs.setme.get 'xx').to.eql void
