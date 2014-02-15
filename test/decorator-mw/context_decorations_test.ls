requires    = require '../../requires'

requires.test 'test_setup'
assert      = require('chai').assert
expect      = require('chai').expect

_           = require 'prelude-ls'
Person      = requires.clazz 'person'
DecoratorMw = requires.mw 'decorator_mw'

# Middleware = require('middleware).Middleware

# load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

# keeps its keys in insertion order at all times.
# http://jsclass.jcoglan.com/hash.html
OrderedHash    = require('jsclass/src/hash').OrderedHash
Decorations    = requires.lib 'decorations'
CtxDecorations = requires.lib 'context_decorations'

describe 'ContextDecorations' ->
  cds = {}

  describe 'create instance' ->
    context 'no args' ->
      before ->
        cds.empty = new CtxDecorations

      specify 'has Hash registry' ->
        cds.empty.repository.constructor.should.eql OrderedHash

      specify 'has no keys' ->
        expect(cds.empty.repository.keys!.length).to.equal 0

    # add better tests, should not allow passing any kind of Object!
    # should validate!
    context 'with hash' ->
      before ->
        cds.basic = new CtxDecorations x: 1, y: 2

      specify 'has Hash registry' ->
        cds.basic.repository.constructor.should.equal OrderedHash

      describe 'repository' ->
        specify 'has 2 keys' ->
          expect(cds.basic.repository.keys!.length).to.equal 2

        specify 'repo x = 1' ->
          expect(cds.basic.find('x')).to.equal 1

        specify 'repo y = 2' ->
          expect(cds.basic.find('y')).to.equal 2

  xdescribe 'get' ->
    context 'empty repo' ->
      before ->
        cds.empty = new CtxDecorations
      specify 'x not found' ->
        expect(dcs.empty.find 'x').to.equal void

  xdescribe 'set' ->
    context 'repo x = 2' ->
      before ->
        cds.setme = new CtxDecorations
        cds.setme.register 'x', 2

      specify 'x is found' ->
        expect(cds.setme.find 'x').to.equal 2