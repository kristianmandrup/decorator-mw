requires  = require '../../requires'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

Person = requires.clazz 'person'

DecoratorMw = requires.lib 'decorator_mw'

# Middleware = require('middleware).Middleware

# load-mw-stack = new Middleware('model').use(decorate: DecoratorMw)

ContextDecorators = requires.lib 'decorations'

describe ContextDecorations ->
  cds = {}

  describe 'create instance' ->
    context 'no args' ->
      before ->
        cds.empty = new ContextDecorations

      specify 'has Hash registry' ->
        cds.empty.repository.constructor.should.eql Hash

      specify 'has no keys' ->
        _.keys(cds.empty.repository).length.should.eql 0

    # add better tests, should not allow passing any kind of Object!
    # should validate!
    context 'with hash' ->
      before ->
        cds.basic = new Decorations x: 1, y: 2

      specify 'has Hash registry' ->
        cds.basic.repository.constructor.should.eql Hash

      specify 'has 2 keys' ->
        _.keys(cds.basic.repository).length.should.eql 2

      specify 'repo x = 1' ->
        cds.basic.repository.x.should.eql 1

      specify 'repo y = 2' ->
        cds.basic.repository.y.should.eql 2

  xdescribe 'get' ->
    context 'empty repo' ->
      before ->
        dcs.empty = new Decorations
      specify 'x not found' ->
        expect(dcs.empty.get 'x').to.eql void

  xdescribe 'set' ->
    context 'repo x = 2' ->
      before ->
        decs.setme = new Decorations
        decs.setme.set 'x', 2

      specify 'x is found' ->
        expect(decs.setme.get 'x').to.eql 2