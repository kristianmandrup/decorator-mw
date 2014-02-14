// Generated by LiveScript 1.2.0
(function(){
  var requires, assert, expect, Person, DecoratorMw, ContextDecorators;
  requires = require('../../requires');
  requires.test('test_setup');
  assert = require('chai').assert;
  expect = require('chai').expect;
  Person = requires.clazz('person');
  DecoratorMw = requires.lib('decorator_mw');
  ContextDecorators = requires.lib('decorations');
  describe(ContextDecorations(function(){
    var cds;
    cds = {};
    describe('create instance', function(){
      context('no args', function(){
        before(function(){
          return cds.empty = new ContextDecorations;
        });
        specify('has Hash registry', function(){
          return cds.empty.repository.constructor.should.eql(Hash);
        });
        return specify('has no keys', function(){
          return _.keys(cds.empty.repository).length.should.eql(0);
        });
      });
      return context('with hash', function(){
        before(function(){
          return cds.basic = new Decorations({
            x: 1,
            y: 2
          });
        });
        specify('has Hash registry', function(){
          return cds.basic.repository.constructor.should.eql(Hash);
        });
        specify('has 2 keys', function(){
          return _.keys(cds.basic.repository).length.should.eql(2);
        });
        specify('repo x = 1', function(){
          return cds.basic.repository.x.should.eql(1);
        });
        return specify('repo y = 2', function(){
          return cds.basic.repository.y.should.eql(2);
        });
      });
    });
    xdescribe('get', function(){
      return context('empty repo', function(){
        before(function(){
          return dcs.empty = new Decorations;
        });
        return specify('x not found', function(){
          return expect(dcs.empty.get('x')).to.eql(void 8);
        });
      });
    });
    return xdescribe('set', function(){
      return context('repo x = 2', function(){
        before(function(){
          decs.setme = new Decorations;
          return decs.setme.set('x', 2);
        });
        return specify('x is found', function(){
          return expect(decs.setme.get('x')).to.eql(2);
        });
      });
    });
  }));
}).call(this);