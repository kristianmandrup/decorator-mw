// Generated by LiveScript 1.2.0
(function(){
  var requires, assert, expect, _, Person, DecoratorMw, OrderedHash, Decorations, CtxDecorations;
  requires = require('../../requires');
  requires.test('test_setup');
  assert = require('chai').assert;
  expect = require('chai').expect;
  _ = require('prelude-ls');
  Person = requires.clazz('person');
  DecoratorMw = requires.mw('decorator_mw');
  OrderedHash = require('jsclass/src/hash').OrderedHash;
  Decorations = requires.lib('decorations');
  CtxDecorations = requires.lib('context_decorations');
  describe('ContextDecorations', function(){
    var cds, dcs;
    cds = {};
    dcs = {};
    describe('create instance', function(){
      context('no args', function(){
        before(function(){
          return cds.empty = new CtxDecorations;
        });
        specify('has Hash registry', function(){
          return cds.empty.repository.constructor.should.eql(OrderedHash);
        });
        return specify('has no keys', function(){
          return expect(cds.empty.repository.keys().length).to.equal(0);
        });
      });
      return context('with hash', function(){
        before(function(){
          var xRepo;
          xRepo = new Decorations({
            'x': function(){
              return '1';
            },
            y: function(){
              return '2';
            }
          });
          return cds.basic = new CtxDecorations({
            'default': xRepo
          });
        });
        specify('has Hash registry', function(){
          return cds.basic.repository.constructor.should.equal(OrderedHash);
        });
        return describe('repository', function(){
          specify('has 2 keys', function(){
            return expect(cds.basic.repository.keys().length).to.equal(1);
          });
          specify('repo x = 1', function(){
            return expect(cds.basic.find('default', 'x')).to.not.equal(null);
          });
          return specify('repo y = 2', function(){
            return expect(cds.basic.find('y')).to.not.equal(null);
          });
        });
      });
    });
    describe('get', function(){
      return context('empty repo', function(){
        before(function(){
          return cds.empty = new CtxDecorations;
        });
        return specify('x not found', function(){
          return expect(cds.empty.find('x')).to.equal(void 8);
        });
      });
    });
    describe('set', function(){
      return context('repo admin: person -> Person', function(){
        before(function(){
          cds.setme = new CtxDecorations;
          dcs.person = function(){
            return 'Person';
          };
          return cds.setme.register('admin', {
            person: dcs.person
          });
        });
        return specify('x is found', function(){
          return expect(cds.setme.find('admin', 'person')).to.equal(dcs.person);
        });
      });
    });
    describe('nice DSL', function(){
      return context('repo admin: user -> User', function(){
        before(function(){
          cds.setme = new CtxDecorations;
          dcs.user = function(){
            return 'User';
          };
          return cds.setme.ctx('admin').register({
            user: dcs.user
          });
        });
        return specify('x is found', function(){
          return expect(cds.setme.ctx('admin').find('user')).to.equal(dcs.user);
        });
      });
    });
    return describe('for-model', function(){
      return context('repo admin: user -> User', function(){
        before(function(){
          cds.setme = new CtxDecorations;
          dcs.user = function(){
            return 'User';
          };
          return cds.setme.forModel('user').register({
            admin: dcs.user
          });
        });
        return specify('x is found', function(){
          return expect(cds.setme.ctx('admin').find('user')).to.equal(dcs.user);
        });
      });
    });
  });
}).call(this);
